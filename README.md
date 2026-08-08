<h1 align="center">Completionist</h1>

<p align="center">
<img width="64" height="64" alt="medivh" src="https://github.com/user-attachments/assets/5e2cb6bf-b0b2-4ef1-bad2-63ffbee7885e" />
</p>

_<p align="center">Keep track of your progress in Azeroth</p>_

**WARNING: This Addon is intended to be used with the Legacy version of Wrath of the Lich King (3.3.5). This Addon is NOT compatible with Classic Era Wrath of the Lich King**.

## Overview

Being a RP nerd, my idea was to make an Addon to plan a lore-friendly leveling route.

**Completionist** lets the player make such plans by keeping track of the zones they have cleared, as well as the zones they plan to visit or skip. The percentage of completion adds up in a counter at the bottom.

## Features

* The **Leveling zones** features a list of leveling zones sorted by level and faction where you can check the ones you have already cleared and right click the zones you plan to skip. A button at the bottom resets the completion counter.
* In the **Instances** tab you can accomplish the same for Dungeons, Raids and World Bosses events -- this Addon is best enjoyed with the [mod-individual-progression](https://github.com/ZhengPeiRu21/mod-individual-progression) module for AzerothCore.
* A **User objectives** tab lets you add and keep track of your own objectives.
* The **Notes** tab serves as a general purpose notepad.

This Addon uses a Persistent Database to save your progress for each character. Everything is safely stored in the `CompletionistDB` across sessions.

## Usage

If for any reason the minimap button fails to load, you can manually launch the addon with the command:

```text
/completionist
```
or
```text
/comp
```
