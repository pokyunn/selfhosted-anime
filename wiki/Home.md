### Pre-requisites

- Have an instance of Unraid server or ha linux, docker and docker-compose knowledge to build it from scratch.
- Hardlinks anabled as shown in TRaSH Guides, read more [here](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/#folder-structure)

## Structure

Templates used:
- linuxserver/emby
- linuxserver/jellyfin 
- linuxserver/qbittorrent
- linuxserver/radarr
- linuxserver/sonarr
- shokoanime/server

You chan use others, just look for what change between them.

- To keep it simple, so i decided to use same user/passwor for all connected instances, as it is a local server

- To make it isolated name shares with sufix `-anime` and all containers to be able to have multiple instances.

Example:
- media-collection `# General media collection`	
- media-collection-anime `# Anime media collection`

Share structure
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

To create it run 
```sh
mkdir -p /mnt/user/media-collection-anime/{torrent/{keep,seed,tmp},shoko,radarr,sonarr,media/{movies,series}}

chown nobody:users -R /mnt/user/media-collection-anime
```

All containers will use same mapping, I've choosen `data` as root mount, as it dont conflit with linux structure and as it starts with `D` it will be on top of the dropdown in UI with is a time saver.

```
/data <=> /mnt/user/media-collection-anime/
```

### Result

[[images/unraid-docker-tab.png]]
