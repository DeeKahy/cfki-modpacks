#!/usr/bin/env bash
# Check Mojang's version manifest for a new Minecraft release. If a
# branch mc/<version> doesn't exist and it's newer than what main
# targets, retarget the working tree's packs at it: bump pack.toml,
# then try to update every mod (mods without builds are reported).
# Prints the new version to $GITHUB_OUTPUT as "version=<v>", or "version=none".
set -euo pipefail

latest=$(curl -sf https://piston-meta.mojang.com/mc/game/version_manifest_v2.json | jq -r '.latest.release')
current=$(grep -E '^minecraft *= *' pack/pack.toml | sed 's/.*"\(.*\)"/\1/')

out=${GITHUB_OUTPUT:-/dev/stdout}
if [ "$latest" = "$current" ] || git ls-remote --exit-code origin "refs/heads/mc/$latest" >/dev/null 2>&1; then
  echo "version=none" >> "$out"
  exit 0
fi

loader=$(curl -sf https://meta.fabricmc.net/v2/versions/loader | jq -r '.[0].version')
echo "New Minecraft release: $latest (fabric loader $loader)"

for pack in pack; do
  sed -i.bak -E "s/^minecraft *=.*/minecraft = \"$latest\"/; s/^fabric *=.*/fabric = \"$loader\"/" "$pack/pack.toml"
  rm "$pack/pack.toml.bak"
done

bash scripts/update-mods.sh
echo "version=$latest" >> "$out"
