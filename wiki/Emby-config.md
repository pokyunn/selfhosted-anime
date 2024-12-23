## Initial configuration

Select the template, remove unused mount points, and map the share

**Notice:** Remove unused ports, or change as you need.

Once the container is up and running, proceed with the creation of an account and skip media library creation for now.

## Libraries metadata config

- Go to `(gear icon) > Dashboard > Plugins` remove `TheTVDB`, in `Catalog` add `Anime` and `AniList` (it's reduntant but some images in AniList are better), restart emby serever (through dashboard menu) 
    - If needed increase delay to fetch `AniDB` in `Anime` plugin

[[images/emby-add-movies.png]]

[[images/emby-add-series.png]]

- `Movies`
  - Library Settings
    - Preferred download language: `Empty`
    - `☑️ Automatically add to collection`
    - Metadata downloaders (Movies): `☑️ TheMovieDb`, **Disable everything else**
    - Image fetchers (Movies): `☑️ TheMovieDb`, **Disable everything else**
- `Series`
  - Library Settings
    - Preferred download language: `Empty`
    - Metadata downloaders (Series): `☑️ AniDB,AniList`, **Disable everything else**
    - Metadata downloaders (Seasons): `Empty`, **Disable everything else**
    - Metadata downloaders (Episodes): `☑️ AniDB`, **Disable everything else**
    - Image fetchers (Series): `☑️ AniDB,AniList`, **Disable everything else**
    - Image fetchers (Seasons): `☑️ Empty`, **Disable everything else**
    - Image fetchers (Episodes): `☑️ Image Capture`, **Disable everything else**
    - Disable: `Automatically merge series that are spread across multiple folders`

As we don`t have a shokofin like for emby, we sometimes need to manualy link series, thats why Renamer add anidb-id into series folders, this makes this task easier

[[images/emby-manual-identify1.png]]

[[images/emby-manual-identify2.png]]

[[images/emby-manual-identify3.png]]

[[images/emby-manual-identify4.png]]

[[images/emby-manual-identify5.png]]

- For movies, tmdb is working with renamer folder name pattern `{Movie Title} ({Release Year})`
