# Disclaimer
> This project was based on https://github.com/shyonae/selfhosted-anime <br> But as i changed some conepts for my use, so I "unforked" it.

# Welcome to the selfhosted-anime guide!

This project uses **Docker** for its infrastructure and **Unraid** as its operating system, so anything else is out of my scope (_fork for you, if needed_). This will give you a **stable and reliable** solution to manage your anime series and movies while having **proper metadata**.

- **I will NOT be using Sonarr and Radarr as media managers... but why?**
  - Two simple reasons, really: Sonarr/Radarr's integration with **TheTVDB** and the fact that you **can't change** it as a metadata source.
  - I like them as products, I use them daily, but with anime, TheTVDB doesn't offer as much as AniDB does. It may work for some shows, but some are going to be divided in "seasons" instead of aknowledging each "season" of said anime as its own being (Ex. Sailor Moon, Pokémon).

- **Sonarr and Radarr will be used only as download manager, all media will be served after processed with Shoko, using AniDB structure in Romaji names** <br> If you don't like this decision, feel free to copy/fork and change as you please!

- **Shoko hashes the files and then compare with AniDB to identify them, so only files and Fansubs registered there will work automatically**

## Along the way I'll explain how I did things **_my way_**, of course a lot of stuff can be changed and improved, that's up to you.

The containers that will be used are the following templates from Unraid APPS:

- linuxserver/qbittorrent
- linuxserver/sonarr
- linuxserver/radarr
- shokoanime/server

I have tested with two media servers:

- linuxserver/jellyfin 
  - Bad UX using webplayer as it remux a lot of MKVs in versions greater than 10.5.5
  - Good UX if you use their [desktop client](https://github.com/jellyfin/jellyfin-media-player)
  - Awesome metadata integration with Shoko using [Shokofin](https://github.com/ShokoAnime/Shokofin)

- linuxserver/emby
  - Good UX using webplayer as it direct play MKVs
  - Lacks a plugin like Shokofin, but can be manualy mitigated using the pugins (Anime, AniList) as metadata source and removing the plugin for TVDB and disabling TMDB for series, but keep for Movies it works ok. Some series (packs) will need to manually identiy use `[anidb-id]` added by shoko renamer.

## Important considerations

- This guide will make **HEAVY** use of hardlinks like explained in [TRaSH Guides](https://trash-guides.info/), you should really give it a read **beforehand**.

To dive in, read the [wiki](https://github.com/pokyunn/selfhosted-anime/wiki).

### Result

[[wiki/images/unraid-docker-tab.png]]
