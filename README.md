# Technical Vanilla

A lightweight Fabric modpack for technical vanilla survival with friends. Carpet, the masa mods backed by Servux, and the standard optimization mods, without changing how vanilla plays. One pack covers everything: Java players install it through their launcher, the server installs the same file, and Bedrock players on phones, consoles, and Windows join through Geyser without installing anything at all.

[Modrinth page](https://modrinth.com/modpack/technical-vanilla) | [Report a problem](https://github.com/DeeKahy/cfki-modpacks/issues)

## What it does

- Full technical toolkit: Carpet on the server, Tweakeroo, Item Scroller, MiniHUD, and Litematica on the client, with Servux feeding them server-side data.
- Runs fast: Sodium for framerate, Lithium for tick rate. Shaders are included but off by default.
- Keeps inventories on death, toggled per player, via [Child Friendly Keep Inventory](https://modrinth.com/mod/child-friendly-keepinventory). New players keep their stuff, veterans keep the challenge.
- Lets Bedrock players join the same server on the same address and port (Geyser and Floodgate, no Java account needed).
- Hides ores from xray clients (AntiXray, preconfigured for the overworld and the nether).

## Mod list

One .mrpack serves both sides. Every mod is tagged with the side it belongs to, so launchers install only the client mods and server tools install only the server mods. Nobody downloads things they don't need.

### Client

| Mod | What it does |
| --- | --- |
| [Sodium](https://modrinth.com/mod/sodium) | Much faster rendering |
| [Iris](https://modrinth.com/mod/iris) | Shader support on top of Sodium |
| [Complementary Reimagined](https://modrinth.com/shader/complementary-reimagined) | Included shaderpack, vanilla look with proper lighting |
| [MakeUp Ultra Fast](https://modrinth.com/shader/makeup-ultra-fast-shaders) | Included shaderpack for weaker computers |
| [Tweakeroo](https://modrinth.com/mod/tweakeroo) | Quality of life toggles: flexible placement, gamma override, inventory previews |
| [Item Scroller](https://modrinth.com/mod/item-scroller) | Move items in bulk with the scroll wheel |
| [MiniHUD](https://modrinth.com/mod/minihud) | Info overlay, light level and structure outlines |
| [Litematica](https://modrinth.com/mod/litematica) | Schematics for building |
| [MaLiLib](https://modrinth.com/mod/malilib) | Library the mods above depend on |
| [Mod Menu](https://modrinth.com/mod/modmenu) | In-game config screens |

Shaders are opt-in: Options, Video Settings, Shader Packs. Players on weak machines can simply leave them off.

### Server

| Mod | What it does |
| --- | --- |
| [Carpet](https://modrinth.com/mod/carpet) | Technical rules and commands: tick warp, hopper counters, and more |
| [Servux](https://modrinth.com/mod/servux) | Feeds structure and world data to MiniHUD and Litematica |
| [Child Friendly Keep Inventory](https://modrinth.com/mod/child-friendly-keepinventory) | Per-player keepInventory |
| [Geyser](https://modrinth.com/mod/geyser) | Lets Bedrock Edition players join |
| [Floodgate](https://modrinth.com/mod/floodgate) | Bedrock players don't need a Java account |
| [AntiXray](https://modrinth.com/mod/anti-xray) | Hides ores from xray clients, config included |
| [spark](https://modrinth.com/mod/spark) | Performance profiler for when TPS drops |
| [Chunky](https://modrinth.com/mod/chunky) | Pregenerate the world so exploring doesn't lag |

### Both sides

| Mod | What it does |
| --- | --- |
| [Fabric API](https://modrinth.com/mod/fabric-api) | Required by nearly everything |
| [Lithium](https://modrinth.com/mod/lithium) | Faster game ticks (on the client this only matters in singleplayer) |

### Missing mods on some versions

This is the full intended list. On a freshly released Minecraft version some of these may be temporarily absent because the mod author hasn't updated yet. The pack tracks its wanted list per version and re-adds each missing mod automatically in the next release after the mod updates. See [MAINTAINING.md](MAINTAINING.md) for how that works.

## Installing

**Players:** open the [Modrinth page](https://modrinth.com/modpack/technical-vanilla) in the Modrinth App (or import it in Prism Launcher) and pick the release that matches your server's Minecraft version.

**Servers:** use a host or panel that accepts Modrinth packs, or install with [mrpack-install](https://github.com/nothub/mrpack-install). The Geyser config is set to share the Java port, so Bedrock crossplay works as long as your host forwards UDP on that port.

**Bedrock players:** add a server with the same address and port as the Java players use. Phones and Windows work directly. Consoles can't enter a custom port and need a workaround like BedrockConnect.

## Versions

Releases are numbered like `1.2.0+26.2`, where the part after the plus is the Minecraft version. The server and all players should be on the same release. Each supported Minecraft version has its own branch in this repository and keeps getting mod updates until it's dropped.

## Contributing and maintenance

The pack is maintained with [packwiz](https://packwiz.infra.link/) and updated by scheduled GitHub Actions. [MAINTAINING.md](MAINTAINING.md) documents the branch layout, the automation, and how to cut a release. Suggestions and bug reports go in the [issues](https://github.com/DeeKahy/cfki-modpacks/issues).

---

Warning. This entire thing is made with ai. It is not something i am proud of, but i wanted a thing without needing to put weeks of my life into it. And i decided "meh people might need this", so i made it public.
