Warning. This entire thing is made with ai. It is not something i am proud of, but i wanted a thing without needing to put weeks of my life into it. And i decided "meh people might need this", so i made it public.

# CFKI Modpack

One [packwiz](https://packwiz.infra.link/) pack (`pack/`), published on
Modrinth as [CFKI](https://modrinth.com/modpack/cfki). Every mod is tagged
with its side, so one `.mrpack` serves everyone: launchers install the
client mods (MaLiLib, Tweakeroo, Item Scroller, MiniHUD, Litematica,
Sodium, Iris + two shaderpacks, Mod Menu), server installers take the
server mods (Servux, Carpet, AntiXray pre-configured for overworld +
nether, Geyser + Floodgate Bedrock crossplay via `clone-remote-port`,
child-friendly-keepinventory, spark, Chunky), and Fabric API, Carpet and
Lithium are shared.

## Branch model

- `main` — development branch: scripts, workflows, this README. **No
  pack.** Workflows always use `main`'s scripts, so tooling fixes land
  here once — never cherry-pick them to version branches.
- `mc/<version>` — one branch per Minecraft version, including the
  latest. A branch always means the same version forever. The pack
  lives only on these branches.

## Automation

- **Update mods** (weekly, or manual dispatch): runs
  `scripts/update-mods.sh` on every `mc/*` branch; opens a PR per branch
  when mods have new builds.
- **Scaffold new Minecraft version** (daily): watches Mojang's version
  manifest; when a new release appears, it branches `mc/<new>` off the
  newest existing version branch, retargets the pack, and removes any
  mod without a compatible build yet — so the new branch launches on day
  one. Removed mods stay listed in `mods.txt` and the weekly updater
  re-adds each one as soon as upstream ships a compatible build.

Nothing publishes automatically — review the PR, test-launch, then export
(`packwiz mr export` in `pack/`) and upload the `.mrpack` to Modrinth
tagged with the game version.

## Local workflow

Always work on a version branch (`git checkout mc/<version>`), never on
`main`, when touching the pack:

```bash
cd pack
packwiz mr add <slug>      # add a mod — ALSO add the slug to mods.txt
packwiz remove <slug>      # remove a mod — ALSO delete it from mods.txt
packwiz update --all       # update within this branch's MC version
packwiz mr export          # build the .mrpack
```

`mods.txt` (per branch) is the list of mods the pack *wants*. The weekly
update re-adds any wanted mod that's missing and removes listed mods that
have no build for the branch's MC version (they come back automatically
once upstream updates). A mod removed with `packwiz remove` but left in
`mods.txt` will therefore reappear; delete it from `mods.txt` to make a
removal permanent.
