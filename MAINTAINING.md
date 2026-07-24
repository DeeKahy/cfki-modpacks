# Maintaining Technical Vanilla

Notes for whoever maintains this repository.

## Branch model

- `main` is the development branch: scripts, workflows, docs. There is no pack here. Workflows always run the scripts from `main`, so a tooling fix lands once and applies to every version branch. Never cherry-pick script changes onto version branches.
- `mc/<version>` holds the pack for one Minecraft version, including the newest one. A branch always means the same version forever. The pack lives in `pack/` on these branches only.

## Automation

Two scheduled workflows, both defined on `main`:

- **Update mods** (weekly, Mondays, or run it manually from the Actions tab). Runs `scripts/update-mods.sh` on every `mc/*` branch and opens a pull request per branch when anything changed. The PR body reports what was updated, what was removed, and what came back.
- **Scaffold new Minecraft version** (daily). Watches Mojang's version manifest. When a new release appears it branches `mc/<new>` off the newest existing version branch, retargets the pack, and removes every mod that has no compatible build yet, so the new branch launches on day one.

Nothing is published automatically. Review the PR, test-launch, then release.

## The wanted list

`pack/mods.txt` on each branch lists the mods the pack wants, one Modrinth slug per line. The weekly update:

- re-adds any wanted mod that's missing, as soon as a compatible build exists
- removes any listed mod that has no build for the branch's Minecraft version (it comes back automatically later)

Consequences:

- To add a mod: `packwiz mr add <slug>` in `pack/` and add the slug to `mods.txt`.
- To remove a mod permanently: `packwiz remove <slug>` and delete the slug from `mods.txt`. If you leave it in the list, the automation will faithfully re-add it.

## Local commands

Work on a version branch, never on `main`, when touching the pack:

```bash
git checkout mc/26.2
cd pack
packwiz mr add <slug>      # add a mod
packwiz update --all       # update within this branch's MC version
packwiz mr export          # build the .mrpack
```

packwiz is installed with `go install github.com/packwiz/packwiz@latest`.

## Cutting a release

1. On the version branch, bump `version` in `pack/pack.toml` (for example `1.2.0`), commit, push.
2. `packwiz mr export` in `pack/` produces `Technical Vanilla-<version>.mrpack`.
3. Upload it on the [Modrinth versions page](https://modrinth.com/modpack/technical-vanilla/versions) with version number `<pack version>+<mc version>` (for example `1.2.0+26.2`), the matching game version, and loader Fabric.

The upload can also be done with the Modrinth API and a personal access token that has the create version scope; see the version creation endpoint in the [Modrinth API docs](https://docs.modrinth.com/).
