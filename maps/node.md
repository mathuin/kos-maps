# Node scripts

node - Executes a maneuver node, warping if necessary

// Example:
//	 run node_peri(orbit:apoapsis). // create the node
//	 run node. // execute the node
// Advanced:
//	 function create_node { ... }
//	 run node(create_node@). // create and execute the node using delegate
// Advanced 2:
//	 run node({run node_create.}). // using anonymous function/delegate

## Altitude

node_alt - make node for new altitude on opposite side of orbit at specified time.

Wrapper scripts include node_apo (change apoapsis at periapsis) and node_peri (change periapsis at apoapsis).

## Inclination

node_inc - make node for new inclination
- requires lib_util

Wrapper scripts include node_inc_equ (set inclination equal to a value) and node_inc_tgt (set inclination equal to that of a target).

## Other

node_hoh - make node for Hohmann transfer
- requires lib_ui, lib_util

node_vel_tgt - make node to match velocities at closest approach (fine-tuning may be required)
- requires lib_ui, lib_util
