# Disclaimer
> This project was based on https://github.com/shyonae/selfhosted-anime <br> But as i changed some conepts for my use, so I "unforked" it.

The [WIKI](https://github.com/pokyunn/selfhosted-anime/wiki) explain how to setup players, containers and structure data in unraid (as its docker based you cand setup it anyware with some knowledge).

## Reason 2B

- Organize and display Anime names in Romaji, which is Japanese names represented in Roman letters
- Is easy to replicate
- Space eficient, using hardlinks to have multiple views of files while saving space
- Have some level of automatation
  - Add torrent in qBittorrent it will send to Shoko wich will analyse and organize media for Jellyfin/Emby
  - Add series/movies to radarr/sonarr they will send qBittorrent and so on

## Container images

- linuxserver/emby
- linuxserver/jellyfin
- linuxserver/qbittorrent
- linuxserver/radarr
- linuxserver/sonarr
- shokoanime/server

## Structure

```
media-collection-anime
├── media
│   ├── movies
│   └── series
├── radarr
├── shoko
├── sonarr
└── torrent
    ├── keep
    ├── seed
    └── tmp
```

## Important considerations

- This guide will make **HEAVY** use of hardlinks like explained in [TRaSH Guides](https://trash-guides.info/), you should really give it a read **beforehand**.

- **I will be using Sonarr and Radarr as Media requesters**
  - Sonarr/Radarr's integration with **TVDB/TMDB** and the fact that you **can't change** it as a metadata source.
  - TVDB/TMDB doesn't offer as much as AniDB does. It may work for some series, but some are going to be divided in "seasons" instead of aknowledging each "season" of said anime as its own being (Ex. Sailor Moon, Pokémon).

- linuxserver/jellyfin 
  - Bad UX using webplayer as it remux a lot of MKVs in versions greater than 10.5.5
  - Good UX if you use their [desktop client](https://github.com/jellyfin/jellyfin-media-player)
  - Awesome metadata integration with Shoko using [Shokofin](https://github.com/ShokoAnime/Shokofin)

- linuxserver/emby
  - Good UX using webplayer as it direct play MKVs
  - Lacks a plugin like Shokofin, but can be manualy mitigated using the pugins (Anime, AniList) as metadata source and removing the plugin for TVDB and disabling TMDB for series, but keep for Movies it works ok. Some series (packs) will need to manually identiy use `[anidb-id]` added by shoko renamer.
