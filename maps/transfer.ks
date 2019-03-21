parameter tgtperi is target:atm:height + target:radius * 0.3.
parameter tgtinc is 0.

function polarDist {
	parameter rA, thetaA, rB, thetaB.

	return sqrt(ra^2+rB^2-2*rA*rB*cos(thetaB-thetaA)).
}

runoncepath("lib_ui").

uiDebug("Target periapsis: " + tgtperi).
uiDebug("Target inclination: " + tgtinc).

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

uiBanner("Transfer", "Transfer injection burn").
run node_hoh.
run node.

uiDebug("Pre-correction target periapsis: " + round(ship:obt:nextpatch:periapsis,2)).
uiDebug("Pre-correction target inclination: " + round(ship:obt:nextpatch:inclination,2)).

uiBanner("Transfer", "Mid-course correction").
add utilOptimizeNode(node(time:seconds+eta:transition/4, 0, 0, 0), {parameter nd. if nd:obt:hasnextpatch { return polarDist(tgtperi, tgtinc, nd:obt:nextpatch:periapsis, nd:obt:nextpatch:inclination). }. return false. }).
run node.

uiDebug("Post-correction target periapsis: " + ship:obt:nextpatch:periapsis).
uiDebug("Post-correction target inclination: " + ship:obt:nextpatch:inclination).

until obt:transition <> "ENCOUNTER" {
	run warp(eta:transition+1).
}

uiBanner("Transfer", "Post-encounter correction").
add utilOptimizeNode(node(time:seconds+eta:periapsis/4, 0, 0, 0), {parameter nd. return polarDist(tgtperi, tgtinc, nd:obt:periapsis, nd:obt:inclination). }).
run node.

uiDebug("Final target periapsis: " + round(ship:obt:periapsis,2)).
uiDebug("Final target inclination: " + round(ship:obt:inclination,2)).

uiBanner("Transfer", "Transfer braking burn").
run circ.
