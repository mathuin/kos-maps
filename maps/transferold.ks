run once lib_ui.

// JMT: adding support for custom apoapsis and inclination.
parameter tgtapo is -1.
parameter tgtinc is 0.

if ship:body <> target:body {
	uiError("Transfer", "Target outside of SoI").
	wait 5.
	reboot.
}

local ri is abs(obt:inclination - target:obt:inclination).

if ri > 0.25 {
	uiBanner("Transfer", "Align planes with " + target:name).
	run node_inc_tgt.
	run node.
}

run node_hoh.
uiBanner("Transfer", "Transfer injection burn").
run node.

until obt:transition <> "ENCOUNTER" {
	run warp(eta:transition+1).
}

// Deal with collisions and retrograde orbits (sorry this script can't do free return)
if tgtperi = -1 {
  set tgtperi to (body:atm:height + (body:radius * 0.3)).
}

if abs(ship:periapsis - tgtperi) > 0.1 * tgtperi or ship:obt:inclination > 90 {
	sas off.
	LOCK STEERING TO heading(90,0).
	wait 10.
	LOCK deltaPct TO (ship:periapsis - tgtperi) / tgtperi.
	LOCK throttle TO max(1,min(0.1,deltaPct)).
	Wait Until ship:periapsis > tgtperi.
	LOCK throttle to 0.
	UNLOCK throttle.
	UNLOCK STEERING.
	sas on.
}

uiBanner("Transfer", "Transfer braking burn").
run circ.
