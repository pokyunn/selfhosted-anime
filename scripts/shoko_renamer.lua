remove_illegal_chars = false
replace_illegal_chars = true

local maxnamelen = 60
local animelanguage = Language.Romaji
local episodelanguage = Language.English
local spacechar = " "
local group = ""

-- Check if anidb and release group keys exist before trying to access them (they may be nil)
if file.anidb and file.anidb.releasegroup then
  group = (file.anidb.releasegroup.shortname or file.anidb.releasegroup.name)
end

local animename = anime:getname(animelanguage) or anime.preferredname
local episodename = ""
local engepname = episode:getname(Language.English) or ""
local episodenumber = ""

-- If the episode is not a complete movie then add an episode number/name
if anime.type ~= AnimeType.Movie or not engepname:find("^Complete Movie") then
  local fileversion = ""
  if (file.anidb and file.anidb.version > 1) then
    fileversion = "v" .. file.anidb.version
  end
  -- Padding is determined from the number of episodes of the same type in the anime (#tostring() gives the number of digits required, e.g. 10 eps -> 2 digits)
  -- Padding is at least 2 digits
  local epnumpadding = math.max(#tostring(anime.episodecounts[episode.type]), 3)
  episodenumber = episode_numbers(epnumpadding) .. fileversion

  -- If this file is associated with a single episode and the episode doesn't have a generic name, then add the episode name
  if #episodes == 1 and not engepname:find("^Episode") and not engepname:find("^OVA") then
    episodename = episode:getname(episodelanguage) or ""
  end
end

local res = file.media.video.res or ""
local codec = file.media.video.codec or ""
local bitdepth = "8bit"
if file.media.video.bitdepth and file.media.video.bitdepth ~= 8 then
  bitdepth = file.media.video.bitdepth .. "bit"
end

local faudiocodec = file.media.audio[1].codec or ""
local faudiochannel = file.media.audio[1].channels or ""

local crchash = ""
-- CRC can be null if disabled in Shoko settings, so need to check it
if file.hashes.crc then
  crchash = file.hashes.crc
end

local truncatedanimename = animename
  :truncate(maxnamelen)
  :gsub( "Gekijouban", '')
  :gsub('\'', '')

if anime.type ~= AnimeType.Movie then
  destination = "series"
  subfolder = string.format(
    "%s [anidb-%s]",
    truncatedanimename,
    anime.id
  ):gsub('[%s]', ' ')

  local season = 1

  if(episodenumber:find('^S')) then
    season = 0
    episodenumber = episodenumber:sub(-3)
  end

  filename = string.format(
    "%s - S%sE%s - %s [%s %s] [%s %s] [%s %s] [%s]",
    truncatedanimename,
    season,
    episodenumber,
    episodename:truncate(maxnamelen),
    file.anidb.source,
    res,
    codec,
    bitdepth,
    faudiocodec,
    faudiochannel,
    group
  ):cleanspaces(spacechar)
else
  destination = "movies"
  subfolder = string.format(
    "%s (%s) [anidb-%s]",
    truncatedanimename,
    anime.airdate.year,
    anime.id
  ):gsub('[%s]', ' ')

  filename = string.format(
    "%s [%s %s] [%s %s] [%s %s] [%s]",
    truncatedanimename,
    file.anidb.source,
    res,
    codec,
    bitdepth,
    faudiocodec,
    faudiochannel,
    group
  ):cleanspaces(spacechar)

  if(episodenumber:find('^S')) then
    episodenumber = episodenumber:sub(-3)
    subfolder = string.format(
      "%s - Specials (%s) [anidb-%s]",
      truncatedanimename,
      anime.airdate.year,
      anime.id
    ):gsub('[%s]', ' ')

    filename = string.format(
      "%s - S%sE%s - %s [%s %s] [%s %s] [%s %s] [%s]",
      truncatedanimename,
      0,
      episodenumber,
      episodename:truncate(maxnamelen),
      file.anidb.source,
      res,
      codec,
      bitdepth,
      faudiocodec,
      faudiochannel,
      group
    ):cleanspaces(spacechar)
  end
end
