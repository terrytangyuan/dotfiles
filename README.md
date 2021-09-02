# dotfiles

* Run `make sync` to upload dotfiles to Github.

## Setup

* Chinese input source:
  * Keyboard -> shortcuts -> input sources -> select the previous input source -> press Tab -> press Command + Space
* Disable Spotlight shortcuts
  * Keyboard -> shortcuts -> Spotlight -> unselect all shortcuts
  * Keyboard -> text -> uncheck correct spelling automatically and others
* Show hidden files
  * Run `defaults write com.apple.finder AppleShowAllFiles YES`
  * Hold `Option` key, then right click on the Finder icon in the dock and click Relaunch.
* Add `subl` shortcut: `sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl`
* Copy git and bash configurations.
* Generate new SSH key via `ssh-keygen -t ed25519 -C "terrytangyuan@gmail.com"; cat /Users/terrytangyuan/.ssh/id_ed25519.pub` and add it to GitHub [here](https://github.com/settings/keys).


### Deprecated

* [Deprecated] Get iTerm.
* [Deprecated] Run `make setup` to setup development environment for a new Mac.
* [Deprecated] Windows keyboard remapping

```
Control -> Command
Option -> Option
Command -> Option
```
* [Deprecated] Enable "Warn Before Quitting" in Chrome
