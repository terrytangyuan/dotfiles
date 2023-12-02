# dotfiles

* Run `make sync` to update/upload dotfiles to Github.

## Setup

* Chinese input source:
  * Keyboard -> shortcuts -> input sources -> select the previous input source -> press Tab -> press Command + Space
* Disable Spotlight shortcuts
  * Keyboard -> shortcuts -> Spotlight -> unselect all shortcuts
  * Keyboard -> text -> uncheck correct spelling automatically and uncheck "Use smart quotes and dashes".
* Show hidden files
  * Run `defaults write com.apple.finder AppleShowAllFiles YES`
  * Hold `Option` key, then right click on the Finder icon in the dock and click Relaunch.
* Stop Mac from adding apps to dock:
  * System Preferences -> Dock & Menu Bar -> uncheck "Show recent applications in Dock"
* Disable smart quotes when editing notes:
  * Notes -> Edit -> Spelling and Grammar -> uncheck all options.
* Install ZSH
* [Disable Caps Lock Indicator](https://discussions.apple.com/thread/255159504)
* Install `git`
* Generate new SSH key via `ssh-keygen -t ed25519 -C "terrytangyuan@gmail.com"; cat /Users/terrytangyuan/.ssh/id_ed25519.pub` and add it to GitHub [here](https://github.com/settings/keys).
* Install `brew`
* Clone this repo
* Run `./setup_machine.sh`
* Copy zsh configurations to `~/.zshrc`
* Add `subl` shortcut: `sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl`
* Install GoLand
* Install Docker Desktop

### Deprecated

* Turn off the sound sound when connecting to the charger: `defaults write com.apple.PowerChime ChimeOnNoHardware -bool true;killall PowerChime`
* [Deprecated] Get iTerm.
* [Deprecated] Run `make setup` to setup development environment for a new Mac.
* [Deprecated] Windows keyboard remapping

```
Control -> Command
Option -> Option
Command -> Option
```
* [Deprecated] Enable "Warn Before Quitting" in Chrome
* Fix the issue with `QLColorCode.qlgenerator` by following [this instruction](https://github.com/anthonygelibert/QLColorCode/issues/51#issuecomment-566209187) (or see below) for `com.adobe.pdf` and `net.daringfireball.markdown` content type.
 >     1. `brew cask install QLColorCode`
 > 
 >     2. `brew install highlight`
 > 
 >     3. `xattr -d -r com.apple.quarantine ~/Library/QuickLook/QLColorCode.qlgenerator`
 > 
 >     4. add `file_UTI` to the LSItemContentTypes section in the file `~/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist` where `file_UTI` is obtained via `mdls -name kMDItemContentType filaneme.ext` (see [here](https://github.com/anthonygelibert/QLColorCode/issues/51#issuecomment-566155289))
 > 
 > 
 > Now QLColorCode should work via spacebar (you might need to relaunch the finder).
 > 
 > This indicates that the file `~/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist` needs to be updated for Catalina MacOS 10.15(.2) as the file UTI properties seems now to be different from the ones that were recognised on Mojave MacOS 10.14.
