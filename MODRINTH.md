# Modrinth listing text

Everything below the line is meant to be pasted into the Modrinth project's
description field. Suggested settings while you're there:

- Title: `Technical Vanilla`
- Slug/URL: `technical-vanilla`
- Summary: `Lightweight technical vanilla pack for client and server: Carpet, masa mods with Servux, Sodium and Iris, Bedrock crossplay through Geyser, and per-player keepInventory.`
- Links: source and issues both to `https://github.com/DeeKahy/cfki-modpacks`

---

Technical vanilla survival for small servers, in one pack for both sides. Java players install it through their launcher, the server installs the same file, and Bedrock players join through Geyser without installing anything.

Every mod is tagged client or server, so launchers only install the client mods and server tools only install the server mods.

**On the client:** Sodium, Iris with two included shaderpacks (off by default), Tweakeroo, Item Scroller, MiniHUD, Litematica, Mod Menu.

**On the server:** Carpet, Servux (feeds MiniHUD and Litematica), AntiXray preconfigured for the overworld and the nether, Geyser and Floodgate for Bedrock crossplay on the Java port, [Child Friendly Keep Inventory](https://modrinth.com/mod/child-friendly-keepinventory) for per-player keepInventory, spark, Chunky.

**Both:** Fabric API, Lithium.

**Bedrock players** join with the same address and port as Java players. Phones and Windows work directly; consoles need a workaround like BedrockConnect because they can't enter a custom port. Bedrock players don't need a Java account.

Releases are numbered like `1.2.0+26.2`, where the part after the plus is the Minecraft version. Server and players should be on the same release. On a freshly released Minecraft version some mods may be temporarily missing until their authors update; they are re-added automatically in a later release.

Maintained per Minecraft version on [GitHub](https://github.com/DeeKahy/cfki-modpacks). Bug reports and suggestions go in the [issues](https://github.com/DeeKahy/cfki-modpacks/issues).
