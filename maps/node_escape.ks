parameter side is 1. // 1: prograde, -1: retrograde

run once lib_util.
run once lib_ui.

function parallel {
	parameter t.

	// add node(t, 0, 0, prodV).
	run node_alt(body:soiradius+1, t).
	wait 0.
	local tt is time:seconds+eta:transition+1.
	local vv is velocityat(ship, tt):orbit.
	local bv is velocityat(ship:body, tt):orbit.
	remove nextnode.
	wait 0.
	return abs(vdot(vv,bv)/(vv:mag*bv:mag)-side).
}

local besttime is utilOptimizeETA(parallel@).
run node_alt(body:soiradius+1, besttime).
