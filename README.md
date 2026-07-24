Warning. This entire thing is made with ai. It is not something i am proud of, but i wanted a thing without needing to put weeks of my life into it. And i decided "meh people might need this", so i made it public.

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

- `main` — development branch: scripts, workflows, this README. **No
  packs.** Workflows always use `main`'s scripts, so tooling fixes land
  here once — never cherry-pick them to version branches.
- `mc/<version>` — one branch per Minecraft version, including the
  latest. A branch always means the same version forever. The packs
  (`server/`, `client/`) live only on these branches.

## Automation

- **Update mods** (weekly, or manual dispatch): runs
  `scripts/update-mods.sh` on every `mc/*` branch; opens a PR per branch
  when mods have new builds.
- **Scaffold new Minecraft version** (daily): watches Mojang's version
  manifest; when a new release appears, it branches `mc/<new>` off the
  newest existing version branch, retargets the packs, and removes any
  mod without a compatible build yet — so the new branch launches on day
  one. Removed mods stay listed in `mods.txt` and the weekly updater
  re-adds each one as soon as upstream ships a compatible build.

Nothing publishes automatically — review the PR, test-launch, then export
(`packwiz mr export` in each pack dir) and upload both `.mrpack`s to
Modrinth tagged with the game version.

## Local workflow

Always work on a version branch (`git checkout mc/<version>`), never on
`main`, when touching packs:

```bash
cd server   # or client
packwiz mr add <slug>      # add a mod — ALSO add the slug to mods.txt
packwiz remove <slug>      # remove a mod — ALSO delete it from mods.txt
packwiz update --all       # update within this branch's MC version
packwiz mr export          # build the .mrpack
```

`mods.txt` (per pack, per branch) is the list of mods the pack *wants*.
The weekly update re-adds any wanted mod that's missing and removes
listed mods that have no build for the branch's MC version (they come
back automatically once upstream updates). A mod removed with
`packwiz remove` but left in `mods.txt` will therefore reappear; delete
it from `mods.txt` to make a removal permanent.
