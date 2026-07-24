#!/usr/bin/env bash
# Update every mod in both packs to the newest build for this branch's
# pinned Minecraft version. Mods with no compatible build are skipped
# and reported (exit code stays 0 so CI can open a PR with the report).
set -uo pipefail

FAILED=()
INCOMPATIBLE=()
REMOVED=()
READDED=()
STILL_MISSING=()
for pack in server client; do
  echo "### $pack"
  cd "$(git rev-parse --show-toplevel)/$pack"
  mc=$(grep -E '^minecraft *= *' pack.toml | sed 's/.*"\(.*\)"/\1/')
  removed_now=""
  packwiz refresh
  for f in mods/*.pw.toml; do
    [ -e "$f" ] || continue
    name=$(basename "$f" .pw.toml)
    if ! packwiz update "$name" -y; then
      FAILED+=("$pack/$name")
      continue
    fi
    # packwiz reports "up to date" even when the pinned build doesn't
    # support this branch's MC version — verify against the Modrinth API.
    modid=$(grep -E '^mod-id *= *' "$f" | sed 's/.*"\(.*\)"/\1/')
    [ -n "$modid" ] || continue
    n=$(curl -sf "https://api.modrinth.com/v2/project/$modid/version?game_versions=%5B%22$mc%22%5D" | jq 'length')
    if [ "${n:-0}" -eq 0 ]; then
      # No build for this MC version: an incompatible jar would crash the
      # pack, so drop it — but only if mods.txt lists it, which guarantees
      # this same script re-adds it once a compatible build ships.
      if [ -f mods.txt ] && grep -qx "$name" mods.txt; then
        packwiz remove "$name"
        REMOVED+=("$pack/$name (no build for $mc)")
        removed_now="$removed_now $name"
      else
        INCOMPATIBLE+=("$pack/$name (no build for $mc, not in mods.txt — handle manually)")
      fi
    fi
  done
  # mods.txt is the list of mods this pack WANTS. Anything listed but not
  # present (e.g. pruned at a new-MC-version bump because upstream hadn't
  # updated yet) is retried here, so it comes back the week its build ships.
  if [ -f mods.txt ]; then
    while IFS= read -r slug; do
      case "$slug" in ''|'#'*) continue;; esac
      case " $removed_now " in *" $slug "*) continue;; esac
      if [ ! -e "mods/$slug.pw.toml" ]; then
        if packwiz mr add "$slug" -y; then
          READDED+=("$pack/$slug")
        else
          STILL_MISSING+=("$pack/$slug")
        fi
      fi
    done < mods.txt
  fi
  packwiz refresh
done

report="$(git rev-parse --show-toplevel)/update-report.txt"
: > "$report"
[ ${#FAILED[@]} -gt 0 ] && printf 'update failed: %s\n' "${FAILED[@]}" >> "$report"
[ ${#INCOMPATIBLE[@]} -gt 0 ] && printf 'INCOMPATIBLE: %s\n' "${INCOMPATIBLE[@]}" >> "$report"
[ ${#REMOVED[@]} -gt 0 ] && printf 'REMOVED until upstream updates (will re-add automatically): %s\n' "${REMOVED[@]}" >> "$report"
[ ${#READDED[@]} -gt 0 ] && printf 'RE-ADDED (build now available): %s\n' "${READDED[@]}" >> "$report"
[ ${#STILL_MISSING[@]} -gt 0 ] && printf 'wanted but no build yet: %s\n' "${STILL_MISSING[@]}" >> "$report"
[ -s "$report" ] || echo "All mods updated cleanly." > "$report"
cat "$report"
