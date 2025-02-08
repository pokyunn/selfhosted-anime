-- Target output is one media directory with all files organized using shoko groups
--
-- Accel World
-- ├── Accel World
-- │   └── [ANSK] Accel World - 01 [BluRay 720p H264 10bit] [AAC 2.0] (B132587A).mkv
-- ├── Accel World OVA
-- │   └── [ANSK] Accel World OVA - 01 [BluRay 720p H264 10bit] [AAC 2.0] (6E91377B).mkv
-- └── Movies
--     └── [ANSK] Accel World： Infinite Burst [BluRay 1080p HEVC 10bit] [AAC 2.0] (E30ACB16).mkv

destination = "media"
remove_illegal_chars = false
replace_illegal_chars = true

local maxnamelen = 60
local animelanguage = Language.Romaji
local episodelanguage = Language.English
local spacechar = " "

-- Check if anidb and release group keys exist before trying to access them (they may be nil)
local releasegroup = "noGroup"
if file.anidb and file.anidb.releasegroup then
  releasegroup = (file.anidb.releasegroup.shortname or file.anidb.releasegroup.name)
end

-- Check if anidb and if file version is greater than 1
local fileversion = ""
if (file.anidb and file.anidb.version > 1) then
  fileversion = " v" .. file.anidb.version
end

local animename = anime:getname(animelanguage) or anime.preferredname
local episodename = ""
local engepname = episode:getname(episodelanguage) or ""
local episodenumber = ""

-- If the episode is not a complete movie then add an episode number/name
if anime.type ~= AnimeType.Movie or not engepname:find("^Complete Movie") then
  -- Padding is determined from the number of episodes of the same type in the anime (#tostring() gives the number of digits required, e.g. 10 eps -> 2 digits)
  -- Padding is at least 2 digits
  local epnumpadding = math.max(#tostring(anime.episodecounts[episode.type]), 2)
  episodenumber = episode_numbers(epnumpadding) .. fileversion

  -- If this file is associated with a single episode and the episode doesn't have a generic name, then add the episode name
  if
      #episodes == 1
      and not engepname:find("^Episode")
      and not engepname:find("^OVA")
      and not engepname:find("^TV Special")
  then
    episodename = episode:getname(episodelanguage) or ""
  end
end

local videoinfo = table.concat({
  file.anidb and file.anidb.source or "",
  file.media.video.res or "",
  file.media.video.codec or "",
  file.media.video.bitdepth and file.media.video.bitdepth .. "bit" or "",
}, " "):cleanspaces(spacechar)

-- get first audioinfo
local audioinfo = table.concat({
  file.media.audio[1].codec or "",
  file.media.audio[1].channels or "",
}, " "):cleanspaces(spacechar)

local crchash = ""
-- CRC can be null if disabled in Shoko settings, so need to check it
if file.hashes.crc then
  crchash = file.hashes.crc
end

-- clean Romaji
local cleananimename = animename
    -- :gsub("Gekijouban", '')
    -- :gsub("Gekijou Soushuuhen", '')
    -- :gsub('Eiga', '')
    :cleanspaces(spacechar)

-- clean Romaji
local cleanepisodename = episodename
    -- :gsub("Gekijouban", '')
    -- :gsub("Gekijou Soushuuhen", '')
    -- :gsub('Eiga', '')
    :cleanspaces(spacechar)

local truncatedanimename = cleananimename:truncate(maxnamelen)
local truncatedepisodename = cleanepisodename:truncate(maxnamelen)

if (anime.id or "") == 3651 then
  truncatedanimename = "Suzumiya Haruhi no Yuuutsu (2009)"
  group.name = "Suzumiya Haruhi no Yuuutsu"
end

local shortanimename = nil
if anime.titles then
  for _, v in ipairs(anime.titles) do
    if
        v.type == "Short"
        and v.name
        and (v.language == episodelanguage or v.language == "Romaji")
    then
      shortanimename = v.name
    end
  end
end

if anime.type == AnimeType.Movie then
  -- group dirs
  if episodenumber:find("^S") then
    subfolder = { group.name, "Movies", "Specials" }
  else
    subfolder = { group.name, "Movies" }
  end

  -- map numbers to romam (common in movies)
  local title = ""
  local epnmap = {
    ["01"] = "I",
    ["02"] = "II",
    ["03"] = "III",
    ["04"] = "IV",
    ["05"] = "V",
    ["06"] = "VI",
    ["07"] = "VII",
    ["08"] = "VIII",
    ["09"] = "IX",
    ["10"] = "X",
  }

  -- build title
  if (#episodenumber > 1 and #truncatedepisodename > 1) then
    title = " " .. (epnmap[episodenumber] or episodenumber) .. ". " .. truncatedepisodename
  end

  filename = string.format(
    "[%s] %s %s [%s] [%s] (%s)",
    releasegroup,
    cleananimename,
    title,
    videoinfo,
    audioinfo,
    crchash
  ):cleanspaces(spacechar)
else
  -- if name is at max lenght then use shortname
  if #truncatedanimename == maxnamelen and shortanimename then
    truncatedanimename = shortanimename
  end

  -- group dirs
  if episodenumber:find("^S") then
    subfolder = { group.name, truncatedanimename, "Specials" }
  else
    subfolder = { group.name, truncatedanimename }
  end

  -- comment if you want to keep epname
  truncatedepisodename = ""

  filename = string.format(
    "[%s] %s - %s %s [%s] [%s] (%s)",
    releasegroup,
    truncatedanimename,
    episodenumber,
    truncatedepisodename,
    videoinfo,
    audioinfo,
    crchash
  ):cleanspaces(spacechar)
end

if anime.restricted then
  destination = "hentai"
end
