#!/usr/bin/env bash
# Update every mod in both packs to the newest build for this branch's
# pinned Minecraft version. Mods with no compatible build are skipped
# and reported (exit code stays 0 so CI can open a PR with the report).
set -uo pipefail

FAILED=()
for pack in server client; do
  echo "### $pack"
  cd "$(git rev-parse --show-toplevel)/$pack"
  packwiz refresh
  for f in mods/*.pw.toml; do
    [ -e "$f" ] || continue
    name=$(basename "$f" .pw.toml)
    if ! packwiz update "$name" -y; then
      FAILED+=("$pack/$name")
    fi
  done
  packwiz refresh
done

report="$(git rev-parse --show-toplevel)/update-report.txt"
if [ ${#FAILED[@]} -gt 0 ]; then
  printf 'no compatible update: %s\n' "${FAILED[@]}" | tee "$report"
else
  echo "All mods updated cleanly." > "$report"
fi
