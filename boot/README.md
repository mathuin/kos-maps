Universal MAPS Boot Loader
==========================

The purpose of this script is to initialize the processor with the state necessary to execute its mission.

MAPS File Transfer
------------------

The boot loader first deletes itself from the processor's volume, then transfers MAPS scripts from the archive.  These scripts are stored in the `/maps` directory on the processor, just as they are on the archive.  By default, all scripts are copied.  For missions which require only a subset of MAPS (and for which volume capacity is an issue), copy the boot loader to another name (say `/boot/boot_small.ks`) and modify the line which reads `SET FLS TO "".` to include a list of required files (for example, `SET FLS TO LIST("lib_ui.ks", "lib_parts.ks").`).

Mission Script
--------------

The boot loader will check the `/start` directory for a mission script, based on the vessel name and the processor's name tag if assigned.  The naming convention for this script is `/start/Vessel Name.ks` for untagged processors and `/start/Vessel Name - Tag Name.ks` for those with tags.

TODO: Modify the boot loader to parse the mission script to identify the minimum subset of MAPS scripts required for the mission, to conserve space.

Disk space usage
----------------

MAPS scripts use about 150kb of memory.  That seems low, but default kOS hard disk values are very small.  A `ModuleManager` patch is required to increase disk capacity to store all MAPS scripts.  Here is an example:
```
@PART[kOSMachine1m]
{
	@MODULE[kOSProcessor]
	{
		diskSpace = 524288
	}
}
@PART[KAL9000]
{
	@MODULE[kOSProcessor]
	{
		diskSpace = 262144
	}
}
@PART[KR-2042]
{
	@MODULE[kOSProcessor]
	{
		diskSpace = 16384
	}
}
@PART[kOSMachineRad]
{
	@MODULE[kOSProcessor]
	{
		diskSpace = 131072
	}
}
```
