declare parameter dt.

set TW to kuniverse:timewarp.

if dt > 0 {
	set TW:MODE to "RAILS".
	tw:warpto(time:seconds + dt).
	wait dt.
	wait until tw:warp = 0 and tw:ISSETTLED.
}
