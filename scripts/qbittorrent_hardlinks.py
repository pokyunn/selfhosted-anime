from os.path import splitdrive, split as dirsplit, basename
import sys
import shlex
import subprocess

path = sys.argv[1]
category = sys.argv[2]

allowed_categories = ["movies", "series"]

if category not in allowed_categories:
    exit()

# The dest_folders NEED to point to the shoko folders, Shoko will analyse them and move to meadia folders.
dest_folders = "/data/shoko" # INTERNAL CONTAINER PATH

drive = splitdrive(path)[0]
folder = dirsplit(path)[0].split("/")[-1]
base = basename(path)

print(f"linking content of: {folder}")
print(f"to: {dest_folders}")

command = "cp -lRf "
command += f'"{path}" "{dest_folders}"'

subprocess.run(shlex.split(command))
print(f"executed: {command}")
