<img width="1638" height="230" alt="image" src="https://github.com/user-attachments/assets/5d2d023e-3dc6-435c-acc1-ebae6ff100dd" />

#  gitIt
*ha, get it?*

**gitIt** searches your `$HOME` directory for any git repositories and returns the status of each active repository. This is the default behavoir of gitIt, simply run `gitIt` and watch it go to work!

**gitIt** can also return a count of all non-ignored repositories and display the paths of each repository in a numbered list. Run `gitIt -l|--list` for this behavior!

## Ignoring repos:
**gitIt** can use REGEX to find the paths of repos you would like to exclude from gitIt's status reports and repository lists. Run `gitIt --ignore-repo <IGNORE-PATTERN>` to add to your `$IGNORE_LIST`. Your `$IGNORE_LIST` is stored and can be viewed/edited at `~/.config/gitIt/ignore.conf`. If manually adding to it, add the full path of a repo you want to ignore for best results!

#  Future of gitIt
We intend to keep adding to this project, adding new useful features and improving existing features!
