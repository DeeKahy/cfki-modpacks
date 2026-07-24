# CLAUDE.md

Technical Vanilla: a Fabric modpack maintained with packwiz, published on
Modrinth as one combined client+server pack.

- Modrinth project: https://modrinth.com/modpack/technical-vanilla (id `3Hdm6o66`)
- GitHub: https://github.com/DeeKahy/cfki-modpacks
- User docs in README.md, maintainer docs in MAINTAINING.md, Modrinth
  listing text in MODRINTH.md.

## Branch model (important)

- `main` = tooling only: scripts, workflows, docs. There is NO pack here.
- `mc/<version>` = the pack for one Minecraft version, in `pack/`. One
  branch per version, including the latest. Branches are permanent and
  never merge into main.
- Scripts/workflows are edited ONLY on main. CI checks out main's
  `scripts/` onto version branches at run time. Never cherry-pick tooling
  commits onto `mc/*` branches.
- Pack changes happen ONLY on `mc/*` branches.

## Commands

packwiz is at `~/go/bin/packwiz` (not on default PATH).

```bash
git checkout mc/26.2 && cd pack
packwiz mr add <slug>     # then ALSO append slug to mods.txt
packwiz remove <slug>     # then ALSO delete slug from mods.txt
packwiz update --all      # updates within this branch's MC version
packwiz mr export         # builds "Technical Vanilla-<version>.mrpack"
packwiz refresh           # rebuild index after manual file edits
```

## The mods.txt contract

`pack/mods.txt` lists wanted Modrinth slugs, one per line. The weekly CI
(`scripts/update-mods.sh`) re-adds wanted-but-missing mods when a
compatible build appears, and removes listed mods that have no build for
the branch's MC version (they return automatically later). A mod removed
from the pack but left in mods.txt WILL be re-added. mods.txt is excluded
from the shipped pack via `pack/.packwizignore`.

## Gotchas

- `packwiz update` says "already up to date" even when the pinned build
  does not support the branch's MC version. update-mods.sh double-checks
  against the Modrinth API; don't trust packwiz alone for compatibility.
- Exported `*.mrpack` files are gitignored, so a stale `pack/` dir can
  survive branch checkouts. `git mv client pack` style renames will nest
  into it. Check the dir doesn't exist before moving things onto it.
- Some mods don't declare their dependencies on Modrinth (Ledger needs
  fabric-language-kotlin but doesn't say so), so packwiz can't chain-add
  them. Verify runtime deps when adding mods.
- Mod side tags (`side = client|server|both` in `pack/mods/*.pw.toml`)
  come from Modrinth metadata and control what installs where. Don't
  hand-edit them without a reason.
- Version numbering on Modrinth: `<pack version>+<mc version>`, e.g.
  `1.0.0+26.2`. Pack version comes from `pack/pack.toml`.

## Automation

Two workflows on main: weekly mod updates (PR per `mc/*` branch) and a
daily Mojang release watcher that scaffolds `mc/<new>` from the newest
existing version branch. Nothing publishes to Modrinth automatically;
releases are manual (see MAINTAINING.md).
