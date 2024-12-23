## Initial configuration

**Make shure all folders are empty before proceding, if you already have media, finish all shoko setup before moving you media in, or it will start to analyse and will slow down the proccess. <br> If your collection is bg, move files in lots or anidb will eventualy block you fo too much api calls**

Select the template, remove unused mount points, and map the share

**Sugestion:** If you already have lots of files, disable all configs bellow and dont create folders for now to start the server "clean", then you configure the renamer, then restart container, and go manually to *Actions > Import > Run Import*, this will make this initial scan a lot faster as less API calls will be made, end after it finishes you can turn all options on in Settings (gear icon), save and restart container, now while it finishes download data, you can start using it (download, watching, etc)

Follow the steps on the Shoko website to run the first setup and.

- For the `Community Sites` I suggest turning off anything related to `The TvDB` and `The Movie DB`. Also, these are the options I use:

[[images/shoko-sites-config1.png]]

[[images/shoko-sites-config2.png]]

- Now let's create some important folders:

[[images/shoko-importfolder1.png]]

- Now, why did we have to create these drop folders? Well, you want them as a place to put the hardlinks from the torrent client. You want an intermediate folder because watching your entire anime folder for changes is really resource heavy and there are also [kernel limits](https://stackoverflow.com/questions/23035042/can-inotify-handle-a-large-amount-of-directories) (RAM / I/O)

So after you finish your import and first organization of files, you can disable "whatch" in destinatin folders to save resources.

## Internal Shoko Server config

Go to the top right and click the gear icon to go into the `Options`, then go to the `Import` section and tick everything there so everything is enabled.

[[images/shoko-importoptions.png]]

Now, you need to install the [LuaRenamer](https://github.com/Mik1ll/LuaRenamer) plugin. Just follow the **installation steps** on the page.

In our unraid, the path will be inside appdata share at `shokoserver/Shoko.CLI/plugins/LuaRenamer`

> Reload container/browser after.

### Make sure this plugin is present otherwise your files won't get renamed and moved to the right directories.

Go to the `Utilities` tab, then on the left go to `File Renaming` (Follow number in the image).

[[images/shoko-renamer.png]]

In the script section, replace all with the code found in the [scripts/shoko_renamer.lua](https://github.com/pokyunn/selfhosted-anime/blob/main/files/scripts/shoko_renamer.lua) file, present in the wiki's repo (thanks to the lovely people on the Shoko Discord server):

It should look like this:

[[images/shoko-renamer2.png]]

At this point you could already try to download an anime and test if everything works or put some file downloaded from IRC/Torrent from some Fansub registered in AniDB.

- **Don't forget to [check](https://trash-guides.info/Hardlinks/Check-if-hardlinks-are-working/) if hardlinks are working.**
