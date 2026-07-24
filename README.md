# CFKI Modpacks

Two [packwiz](https://packwiz.infra.link/) packs, published on Modrinth as
separate projects:

- **`server/`** — CFKI Server: Servux, Carpet, AntiXray (pre-configured for
  overworld + nether), Geyser + Floodgate (Bedrock crossplay on the Java
  port via `clone-remote-port`), child-friendly-keepinventory, Lithium,
  spark, Chunky.
- **`client/`** — CFKI Client: masa suite (MaLiLib, Tweakeroo, Item
  Scroller, MiniHUD, Litematica), Sodium + Iris with two shaderpacks,
  Mod Menu, Lithium (singleplayer only).

## Branch model

- `main` — latest Minecraft release (may be missing mods that haven't
  updated yet).
- `mc/<version>` — maintained older versions (e.g. `mc/26.2`).

## Automation

- **Update mods** (weekly, or manual dispatch): runs
  `scripts/update-mods.sh` on `main` and every `mc/*` branch; opens a PR
  per branch when mods have new builds. Mods with no compatible build are
  listed in the PR body.
- **Scaffold new Minecraft version** (daily): watches Mojang's version
  manifest; when a new release appears, retargets the packs, updates what
  it can, and opens a PR against `main`. To promote: merge it, and first
  create `mc/<old-version>` from the pre-merge `main` so the old version
  stays maintained.

Nothing publishes automatically — review the PR, test-launch, then export
(`packwiz mr export` in each pack dir) and upload both `.mrpack`s to
Modrinth tagged with the game version.

## Local workflow

```bash
cd server   # or client
packwiz mr add <slug>      # add a mod — ALSO add the slug to mods.txt
packwiz remove <slug>      # remove a mod — ALSO delete it from mods.txt
packwiz update --all       # update within this branch's MC version
packwiz mr export          # build the .mrpack
```

`mods.txt` (per pack, per branch) is the list of mods the pack *wants*.
The weekly update re-adds any wanted mod that's missing — this is how mods
pruned at a new-MC-version bump come back automatically once upstream
ships a compatible build. A mod removed with `packwiz remove` but left in
`mods.txt` will therefore reappear; delete it from `mods.txt` to make a
removal permanent.
