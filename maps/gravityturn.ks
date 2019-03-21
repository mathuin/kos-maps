// Launch with gravity turn

parameter apo is 200000.
parameter hdglaunch is 90.
parameter startSpeed is 50. // 50
parameter startTurn is 1. // 17
parameter TWR is 1.5. // 1.5
parameter chaseApo is 45. // 45

runoncepath("lib_parts").
runoncepath("lib_ui").
runoncepath("lib_util").
runoncepath("lib_warp").
runoncepath("lib_staging").

local turnAngle to 0.
local followTWR to true.
local apoPid to pidloop(0.1, 0.01, 0.05).
set apoPid:setpoint to chaseApo.

uiBanner("ascend","Ascend to " + round(apo/1000) + "km; heading " + hdglaunch + "º").

local deployed is false.
function ascentDeploy {
	if deployed return.
	if ship:altitude < ship:body:atm:height return.
	set deployed to true.
	if partsDeployFairings() {
		uiBanner("ascend", "Discard fairings").
		wait 0.
	}
	partsExtendSolarPanels(core:part:tag).
	partsExtendAntennas(core:part:tag).
}

local oldThrottle to 0.
function ascentThrottle {
	if followTWR {
		if ship:availablethrust = 0 { return 0. }
		set oldThrottle to TWR * body:mu/((ship:altitude+body:radius)^2) * (ship:mass/ship:availablethrust).
		if oldThrottle > 1 {
			set oldThrottle to 1.
		}
		return oldThrottle.
	}
	return oldThrottle + apoPid:update(time:seconds, eta:apoapsis).
}

// turn on SAS and set throttle to TWR of approximately 1.5.
sas on.
lock throttle to ascentThrottle().
lock steering to heading(hdglaunch, 90-turnAngle).

// launch
local warped to false.
until ship:obt:apoapsis >= apo {
	stagingCheck().
	ascentDeploy().
	if velocity:surface:mag > startSpeed {
		// when speed reaches 50 m/s, pitch over 5 degrees and steer hdglaunch.
		set turnAngle to startTurn.
		if utilIsShipFacing(heading(hdglaunch, 90-startTurn):vector) {
			// when stabilized, turn off SAS
			sas off.
			unlock steering.
		}
	}
	// when altitude reaches 40 km or eta:apoapsis > 45sec, chase apo.
	if eta:apoapsis > chaseApo { set followTWR to false. }
	// if not warped and ship:altitude > min(ship:body:atm:height/10, 1000) {
	// 	set warped to true.
	// 	physWarp(1).
	// }
	wait 0.
}

// when apo reaches target, cut coast circularize.
uiBanner("ascend", "Engine cutoff").
unlock throttle.
set ship:control:pilotmainthrottle to 0.

// Roll with top up
uiBanner("ascend","Point prograde").
lock steering to heading (hdglaunch,0). //Horizon, ceiling up.
wait until utilIsShipFacing(heading(hdglaunch,0):vector).

// Warp to end of atmosphere
local AdjustmentThrottle is 0.
lock throttle to AdjustmentThrottle.
until ship:altitude > body:atm:height {
	if ship:obt:apoapsis < apo {
		set AdjustmentThrottle to ascentThrottle().
		stagingCheck().
		wait 0.
	} else {
		set AdjustmentThrottle to 0.
		wait 0.5.
	}
}
if warped resetWarp().
// Discard fairings and deploy panels, if they aren't yet.
ascentDeploy().
wait 1.

// Circularize
unlock all.
run circ.
