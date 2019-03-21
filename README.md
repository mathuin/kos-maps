Introduction
============

Mostly Accurate Planning Software (MAPS) is a collection of kOS scripts designed to help the typical player play the game without getting too deep in some of the more fiddly bits.

Sounds familiar...
------------------

It was heavily inspired by [RAMP](https://github.com/xeger/kos-ramp) and shares much of its philosophy, and (at least at first) much of its code as well.

RAMP focuses on safe, modular, reusable, educational, and ethical code.  I like the naming style, I like the flat control flow, I like all of these things.

I also want some additional rigor.  I need to develop a style guide for KerboScript that covers as many details as I can.  The language itself is almost Perlish in its flexibility which is great for tinkering and hell on maintainability.

Example style guide topics:
* All code shall be written in uppercase.
* Code shall be terse yet readable.
* Documentation shall reside in markdown files, with minimal comments in the code due to size constraints.
* The use of aliases (i.e., `HEADING` in place of `SHIP:HEADING` or `MUN` in place of `BODY("Mun")`) shall be kept to a minimum.
* Function declarations will not include `DECLARE`, `LOCAL`, or `GLOBAL`.
* Function calls shall have parentheses, even when they have no arguments.
* All `if` and `for` expressions shall wrap their blocks in curly braces.
* Enable (`Config:SAFE`)[https://ksp-kos.github.io/KOS/structures/misc/config.html#attribute:CONFIG:SAFE].
* Use [`@LAZYGLOBAL OFF.`](https://ksp-kos.github.io/KOS/language/variables.html#lazyglobal-directive) in all top-level scripts.

Directory layout
================

The majority of MAPS scripts can be found in the `./maps` directory.  Boot scripts are kept in the `./boot` directory, while the `./start` directory is for mission scripts.

TODO: Add support for writing to `./tmp` on vessels.

Installation
============

From the git checkout, it should be as easy as:

```
$ git archive HEAD | (cd ~/.steam/steam/steamapps/common/Kerbal\ Space\ Program/Ships/Script && tar xvf -)
```
