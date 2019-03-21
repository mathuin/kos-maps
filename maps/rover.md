# Rover scripts

rover - Rover menu for driving, routing, and convoying.

rover_autosteer - Automatically steer rover to follow a vessel or to one or more waypoints
- requires lib_ui, lib_parts, lib_terrain, lib_rover

roverconvoy - convoys rover with all targets
- requires lib_ui, rover_autosteer

roverdrive - actually drives the rover (possible duplicate of rover_autosteer)
- requires lib_ui, lib_util, lib_parts, lib_terrain, lib_rover

roverroute - loads rover route and steers
- requires lib_ui, rover_autosteer
