# FirstMageKit

[![Scripts](https://github.com/szapp/FirstMageKit/actions/workflows/scripts.yml/badge.svg)](https://github.com/szapp/FirstMageKit/actions/workflows/scripts.yml)
[![Validation](https://github.com/szapp/FirstMageKit/actions/workflows/validation.yml/badge.svg)](https://github.com/szapp/FirstMageKit/actions/workflows/validation.yml)
[![Build](https://github.com/szapp/FirstMageKit/actions/workflows/build.yml/badge.svg)](https://github.com/szapp/FirstMageKit/actions/workflows/build.yml)
[![GitHub release](https://img.shields.io/github/v/release/szapp/FirstMageKit.svg)](https://github.com/szapp/FirstMageKit/releases/latest)  
[![World of Gothic](https://raw.githubusercontent.com/szapp/patch-template/main/.github/actions/initialization/badges/wog.svg)](https://www.worldofgothic.de/dl/download_620.htm)
[![Spine](https://raw.githubusercontent.com/szapp/patch-template/main/.github/actions/initialization/badges/spine.svg)](https://clockwork-origins.com/spine)
[![Steam Gothic 1](https://img.shields.io/badge/steam-Gothic%201-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2787318379)
[![Steam Gothic 2](https://img.shields.io/badge/steam-Gothic%202-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2787317718)

The patch contains a collection of spells to make the life of a mage easier (Gothic, Gothic Sequel, Gothic 2 and Gothic 2 NotR).

This is a modular modification (a.k.a. patch or add-on) that can be installed and uninstalled at any time and is virtually compatible with any modification.
It supports <kbd>Gothic 1</kbd>, <kbd>Gothic Sequel</kbd>, <kbd>Gothic II (Classic)</kbd> and <kbd>Gothic II: NotR</kbd>.

<sup>Generated from [szapp/patch-template](https://github.com/szapp/patch-template).</sup>

## About

Gothic or any mod may be as polished as possible. If you've ever played a mage before, you might have had to take a hit: If you don't like to pick locks as it does not fit the profile of a mage, you may have longed for a lock picking spell. Furthermore, a full-mage character may have consumed all mana potions available in the game and wished for a spell to exchange mana for health points.

This patch aims to alleviate these shortcomings with additional spells.

- **Lock picking**  
  Scrolls are available from traders and in chests that contain lock picks. The value of the scrolls is based on the value of lock picks in the played mod/game. Each latch of the lock requires 5 mana points (and around 1.5 seconds) and you open as many latches as long as the spell is kept alive or until you run out of mana. Harder locks thus may require multiple scrolls - just as you'd need several lock picks. That also means: If you don't have a lot of mana, you will have to use more scrolls for one lock. Consequently, lock picks remain favorable for non-magic players.

- **Mana-for-life**  
  This spell exchanges health points for mana points. The ratio can be adjusted in the Gothic.ini: `[MANAFORLIFE]` — `hpPerOneMana=2`. In order not to allow any unworthy novice to use the spell, it is available as rune of the third magic circle. The rune is placed in the player's inventory. To not use it as an money exploit, the rune carries no value.

<div align="center">
<img src="https://github.com/szapp/FirstMageKit/assets/20203034/8b664ca4-27e1-4087-8276-8aba74078835" alt="Screenshot" width="44%" /> &nbsp;
<img src="https://github.com/szapp/FirstMageKit/assets/20203034/c4411525-9809-4b81-9af8-cc23033977b8" alt="Screenshot" width="45%" />
</div>

## Notes

* The names and descriptions of the spells automatically adjust to the game's language.
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagDE.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagEN.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagPL.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagRU.png)](#)
* Should either of the spells already exist in a mod, they take precedence. The patch will not insert them, to not interfere with other mods.
* The spell mana-for-life stems from the [Zauberpaket](https://forum.worldofplayers.de/forum/threads/1468949) (spell package).
* The lock picking spell was release [here](https://forum.worldofplayers.de/forum/threads/1547129).

> [!Note]
> When removing the patch it's best to un-equip the spells before.

## Installation

1. Download the latest release of `FirstMageKit.vdf` from the [releases page](https://github.com/szapp/FirstMageKit/releases/latest).

2. Copy the file `FirstMageKit.vdf` to `[Gothic]\Data\`. To uninstall, remove the file again.

The patch is also available on
- [World of Gothic](https://www.worldofgothic.de/dl/download_620.htm) | [Forum thread](https://forum.worldofplayers.de/forum/threads/1547130)
- [Spine Mod-Manager](https://clockwork-origins.com/spine/)
- [Steam Workshop Gothic 1](https://steamcommunity.com/sharedfiles/filedetails/?id=2787318379)
- [Steam Workshop Gothic 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2787317718)

### Requirements

<table><thead><tr><th>Gothic</th><th>Gothic Sequel</th><th>Gothic II (Classic)</th><th>Gothic II: NotR</th></tr></thead>
<tbody><tr><td><a href="https://www.worldofgothic.de/dl/download_34.htm">Version 1.08k_mod</a></td><td>Version 1.12f</td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 1.30.0.0</a></td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 2.6.0.0</a></td></tr></tbody>
<tbody><tr><td colspan="4" align="center"><a href="https://github.com/szapp/Ninja/wiki#wiki-content">Ninja 3</a> or higher</td></tr></tbody></table>

<!--

If you are interested in writing your own patch, please do not copy this patch!
Instead refer to the PATCH TEMPLATE to build a fundation that is customized to your needs!
The patch template can found at https://github.com/szapp/patch-template.

-->
