## Initial configuration

Select the template, remove unused mount points, and map the share

**Notice:** Remove unused ports, or change as you need.

Once the container is up and running, proceed with the creation of an account and skip media library creation for now.

## Shokofin plugin installation

Go to `Dashboard > Catalog` and configure [Shokofin](https://github.com/ShokoAnime/Shokofin) using official repository instuctions.

Once you've restarted Jellyfin connect the plugin to Shoko 
- Put your local server address `http://YourServerIP:8111` in the `Connection Settings` and test, you should see sho version ex `Version 5.0.0.0 (Stable, 76da970)`

- Configure the `Metadata Settings` checking all `Shoko | Let Shoko decide` and save.

[[images/jellyfin-shokofin-metadata.png]]

Now create media libraries for movies and series

[[images/jellyfin-add-movies.png]]

[[images/jellyfin-add-series.png]]

## Libraries metadata config

Now we can set to accept all metadata from Shoko:

These are the settings I will modify for both the `Series` medialibrary and the `Anime Movies` one:

- `Movies`
  - Library Settings
    - Preferred download language: `Empty`
    - `☑️ Automatically add to collection`
    - Metadata downloaders (Movies): `☑️ Shoko`, **Disable everything else**
    - Image fetchers (Movies): `☑️ Shoko`, **Disable everything else**
- `Series`
  - Library Settings
    - Preferred download language: `Empty`
    - Metadata downloaders (TV Shows): `☑️ Shoko`, **Disable everything else**
    - Metadata downloaders (Seasons): `☑️ Shoko`, **Disable everything else**
    - Metadata downloaders (Episodes): `☑️ Shoko`, **Disable everything else**
    - Image fetchers (TV Shows): `☑️ Shoko`, **Disable everything else**
    - Image fetchers (Seasons): `☑️ Shoko`, **Disable everything else**
    - Image fetchers (Episodes): `☑️ Shoko`, **Disable everything else**

After this, in the same menu as above:

- hit `Scan All Libraries`

If you have this annoing problem with MKVs, while remuxing audio goes out off sync and playback stutter:

[[images/jellyfin-remux.png]]

Download [Jellyfin Media Player
](https://github.com/jellyfin/jellyfin-media-player) and point it to Your server.