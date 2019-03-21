# Documentation

Node scripts are documented elsewhere.

Rover scripts are documented elsewhere.

## Libraries

Libraries should have their own documentation files.

lib_dock - docking functions (assumes every ship has one port)

lib_land - landing functions

lib_parts - parts functions
- implied requirement for lib_staging's "stagingMaxStage"

lib_rover - rover functions
- implied requirement for lib_terrain and lib_parts in main program

lib_staging - logic for staging and deltaV calculation.  Stages when available thrust is zero, or all staging engines have flamed out, or all staging tanks are empty (handles asparagus and throwing-off-empty designs like Kerbal X).  Includes support for "noauto" tag on decouplers to prevent inadvertent staging.

lib_terrain - terrain functions

lib_ui - UI functions

lib_util - general utility functions

lib_warp - warp functions

## Scripts

approach - kills transverse velocity with respect to target and establishes forward velocity.
- requires lib_util, lib_dock, lib_ui, warp

circ_alt - circularizes at a designated altitude, immediately if possible, else at the next apsis.
- requires node_alt, node_apo, node_peri, node

circ - circularize at the nearest apoapsis or periapsis
- requires lib_ui, lib_util, node, node_apo, node_peri, lib_staging, lib_warp

deorbitsp - deorbit spaceplane at Kerbin
- requires lib_ui, lib_parts, lib_util, node_inc_equ, node, circ_alt, fly

depart - undocks, backs away with RCS, then transfers control to root/control part
- requires lib_dock, lib_util, lib_ui

dock - chooses arbitrary docking port on vessel and on target (or targeted port), moves into alignment, and approaches at slow speed
- requires lib_ui, lib_dock, lib_parts, approach

fly - pilots planes, can reenter shuttles with "SHUTTLE" argument
- requires lib_ui, lib_parts

gravityturn - trash
- requires lib_parts, lib_ui, lib_util, lib_warp, lib_staging

initialize - creates sample mission in start directory
- requires "0:/mission/sample.ks"

land - make groundfall
- requires lib_ui

landvac - make groundfall on bodies without atmospheres (!) modes: TARG (land on selected target), COOR (land on optional supplied lat long), SHIP (land directly underneath ship's current location)
General logic: move to a circular zero-inclination orbit, calculate a Hohmann transfer with a target altitude of 1% of the body radius above terrain, calculate phase angle so periapsis is over landing site, take a point 270 deg before landing site for plane change, do the deorbit burn
- requires lib_ui, lib_util, lib_land, node_inc_equ, node, circ

launch_asc - vertical launch, performing "gravity turn" and staging as necessary, circularizing at target apoapsis.
- requires lib_parts, lib_ui, lib_util, lib_warp, lib_staging, circ

launch_ssto - horizontal launch (single stage to orbit)
- requires lib_ui, lib_parts, circ

launch - wrapper script for vertical and horizontal launches
- requires launch_asc, launch_ssto

match - match velocity with target (wrapper around dockMatchVelocity)
- requires lib_ui, lib_util, lib_dock ??

rendezvous - Maneuver close to another vessel orbiting the same body
- requires lib_ui, lib_util, approach, match, dock

transfer - Perform Hohmann transfer to satellite of the vessel's SoI body.
- requires lib_ui, node_inc_tgt, node, node_hoh, warp, circ

warp - Warp time
