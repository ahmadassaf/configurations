
In every developer time, there comes a time when he has to set-up his new working environment. For me, the transition from Windows powered PC to a Mac OSX powered laptop was one of the best things i did in my carer. I found the openness of things you can do on a Unix based system accompanied with a solid appealing set of software. 
However, setting everything the way you **want** it can be time consuming, so i decided after few trials and errors to share my experience in customizing my machine and how it can be easily transfered into other machines as well.

## Customizing the UI

![screenshot of my OSX Yosemite Desktop](https://github.com/ahmadassaf/configurations/blob/master/screenshots/mac_osx_desktop.png)

First, lets start with the light weight things. The desktop and general UI enhancement. I always love to show some nice widgets on my desktop, for that i am using [Übersicht](http://tracesof.net/uebersicht/). I have used [Geektool](http://projects.tynsoe.org/en/geektool/) which basically allows you to run custom scripts and display them on the desktop, but i wasn't at all happy with the experience of styling those "widgets" and the availability of 3rd party widgets. 
**Übersicht** lets you run system commands and display their output on your desktop in little containers, called widgets. Widgets are written using HTML5, which means they are:

- Easy to write and customize
- Can show data in tables, charts, graphs ... you name it
- Can react to different screen sizes

There is already a nice set of widgets published in the [gallery](http://tracesof.net/uebersicht-widgets/). In my `widgets` folder, you will find the set of widgets i am using with customized positioning and styling.

### Widgets

- [simple-date](https://github.com/ahmadassaf/configurations/blob/master/widgets/simple-date.coffee) for the date and time in the middle of the screen
- [prayer](https://github.com/ahmadassaf/configurations/tree/master/widgets/prayer.widget) to show the Muslim prayer times for my area, the green indicating the current active prayer time
- [weather](https://github.com/ahmadassaf/configurations/tree/master/widgets/weather.widget) to show the nice weather forecast. It uses the [Free Geo IP](http://freegeoip.net/) API to obtain your location, and the [Yahoo Weather API](https://developer.yahoo.com/weather/) to obtain the weather information.
- **System Stats**
    - [disk-usage](https://github.com/ahmadassaf/configurations/tree/master/widgets/disk-usage.widget): Shows disk usage for mounted disks, with the option to exclude specific disks.
    - [network-info](https://github.com/ahmadassaf/configurations/tree/master/widgets/network-info.widget): Displays current Ethernet and Wi-Fi status (connected / not connected / IP Address / Mac Address.
    - [pubic_ip](https://github.com/ahmadassaf/configurations/tree/master/widgets/public_ip.widget): Displays the current public IP address.
    - [swap-usage](https://github.com/ahmadassaf/configurations/tree/master/widgets/swap-usage.widget): Display swap file metrics for your system.
    - [top-cpu](https://github.com/ahmadassaf/configurations/tree/master/widgets/top-cpu.widget): Shows CPU usage summary.
    - [top-mem](https://github.com/ahmadassaf/configurations/tree/master/widgets/top-mem.widget): Shows a memory usage summary.
    - [network-throughput](https://github.com/ahmadassaf/configurations/blob/master/widgets/network-throughput.coffee.buggy): Shows incoming and outgoing throughput on a user-specified network interface.
    - [total-mem](https://github.com/ahmadassaf/configurations/tree/master/widgets/total-mem.widget): Total system memory benchmarks.

#### Installation

- Installing Übersicht can be bone using the downloadable [zip file](http://tracesof.net/uebersicht/releases/Uebersicht-0.3.13.app.zip) or the recommended using would be via cask (which i will explain later) via `brew cask install ubersicht`
- Installing the widgets is done by copying the **contents** of the widgets folder into `Library -> Application Support -> Übersicht -> widgets`. However, what i do is i setup my widgets to be in my Github repo or dropbox folder so that they are synced and can be backed up and i link the folder directly to the desired location via `ln -s ~/Projects/Configurations/config/widgets/ ~/Library/Application\ Support/Übersicht/widgets` where the first parameter is the location of the `widgets/` folder cloned.
**Note** I have included the folder link in my `.osx` file, you may need to adjust the path of the first argument.

### Other Widgets

One element that i use that is not part of Übersicht is [Dateline](https://itunes.apple.com/us/app/dateline/id406119724?mt=12). It is a discrete desktop calendar with support to iCal and other calendar applications.

### Geeklets
 
In the `Geeklets/` folder there is a backup of the deprecated Geeklet scripts that i used with the old Geektool. If you still prefer it over Übersicht then feel free to use them.

### Dock & Desktop Icons

In the `Flat Icons .icns Format` you will find the set of flat icons i have used for my mounted HDD icons and the dock. 
To easily change application icons, i suggest you use [LiteIcon](http://www.macupdate.com/app/mac/24764/liteicon) which can be also installed via my `caskfile.sh`

To further customize the dock, i use [Dockmod](http://spyresoft.com/dockmod/) which is the most feature-rich application for dock theming with support up to OSX Yosemite in order to provide a transparent Dock background. Dockmod can be also installed via my `caskfile`.

I also remove the arrow icons for aliases/shortcuts which can be done automatically when executing my `.osx` file or manually by typing the following command in the terminal:
`mv /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AliasBadgeIcon.icns /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AliasBadgeIcon_OFF.icns`

### Finder

Although i have the latest OSX Yosemite update, i am still unhappy with the capabilities of the Finder. I have found that [PathFinder](http://www.cocoatech.com/pathfinder/) is a great replacement. Just head over and you can check the list of things you can do with this great piece of software.

### Other Tools

- **[Flexiglass](http://www.nulana.com/flexiglass/)**: Flexiglass features complete and convenient window management with exclusive multi-touch gestures support, offering a simple way to manage many windows on a Mac with a mouse, keyboard, trackpad, and graphics tablet. It includes different tools to move, resize, and arrange windows on the screen easily and joyfully.
- [Bartender](http://www.macbartender.com/): Bartender lets you organize your menu bar apps, by hiding them, rearranging them, or moving them to Bartender's Bar. You can display the full menu bar, set options to have menu bar items show in the menu bar when they have updated, or have them always visible in Bartender's Bar.
- **[Alfred](http://www.alfredapp.com/)**: Alfred saves you time when you search for files online or on your Mac. Be more productive with hotkeys, keywords and file actions at your fingertips. It is super useful with the **powerpack** activated with features like clipboard history.
- **[Caffeine](http://lightheadsw.com/caffeine/)**: Caffeine is a tiny program that puts an icon in the right side of your menu bar. Click it to prevent your Mac from automatically going to sleep, dimming the screen or starting screen savers.

## Setting-up the Machine 

Developers are very picky about their working environment. We may consolidate various `.` files tailed for our tastes over years and track the change in a version control system. It’s no secret that on the UNIX world, dotfiles play a very important part when it comes to making your terminal look good. Be it on Linux, be it on a Mac. Dotfiles are there so you can configure your favorite software to look just the way you like it.

Dotfiles can be used to customize the look of the terminal, to manage bundles with Vim and saving configuration for almost anything. 

One thing that normally annoys me, is the fact that whenever I rebuild my machine (or build a new one) I need to copy over my dotfiles, and obviously make sure they are kept up-to-date on all my devices when I change something.

My configuration consists of the following:

- Mac OSX terminal with bash shell configured with a forked [bash-it](http://github.com/ahmadassaf/bash-it) configurations
- iTerm2 terminal with zsh shell configured with a forked [oh-my-zsh](http://github.com/ahmadassaf/oh-my-zsh) configurations
- A cloned `gitignore` repo for easy fetching of `.gitignore` files into various projects 
- A Custom set of [dotfiles](http://github.com/ahmadassaf/dotfiles) for various machine-wide configurations

# Installation 

First of all you will have to clone this repository into your local machine, and since there are a bunch of other git modules in this repo, you will need to recursively clone this repository and all of it children using:

`git clone --recursive http://github.com/ahmadassaf/Configurations`

Afterwards you can launch the installation by running `sh install.sh`. What this will do is:

- It will ask you if you would like to run an update using the `update.sh` script. Usually this is good when you have lots of changes in your repos and you wish to fetch all the changes afterwards, but simply skip this if this is a fresh installation.
- It will install the `oh-my-zsh` scripts by symlinking the folder and the `zshrc` into the `~` folder. 
- It will prompt if you wish to install `zsh-syntax-highlighting` and does that automatically.
- It will install the `bash-it` script files and guide throughout the installation process.
- It will prompt if you would like to add the Aliases defined also to your `zsh` aliases *recommended*
- It will symlink the dotfiles into your `~` folder.
- It will install `homebrew` and the following brew formulas:

    + **Core Modules** coreutils, moreutils, findutils, binutils
    + **Bash, Bash plugins** bash, bash-completion, zsh
    + **Development** git, heroku, node, mercurial
    + **Git speific addons** git-extras, hub, bfg
    + **Utilities** htop-osx, id3tool, lesspipe, ssh-copy-id, the_silver_searcher, tree, fcrackzip, foremost, ack, p7zip, pigz, pv, gnu-sed, vim, wget
    + **Network tools** dns2tcp, knock, rename, webkit2png
    + **[Dupes](https://github.com/Homebrew/homebrew-dupes)** grep, screen
    
- It will install `cask` and the following applications:

    + **Utilities** path-finder, alfred, cakebrew, a-better-finder-rename, fastscripts, bettertouchtool, iterm2, launchrocket, gyazo, ubersicht, dockmod, liteicon, cleanmymac, bartender, flexiglass
    + **Productivity** todoist, evernote, mendeley-desktop, fantastical, slack, screenhero
    + **Development** sublime-text3, atom, sourcetree, github, brackets, coda, tower, transmission-remote-gui, macvim, sqlite-database-browser, lightpaper, codebox, anvil, hex-fiend, ksdiff, codekit, MAMP
    + **Internet, Networking** firefox, google-chrome, charles, dropbox, google-drive, mailbox, viber, utorrent, plex-media-server
    + **Misc** vlc, imagealpha, imageoptim, steam, the-unarchiver, spotify, handbrake
    + **Quick Look plugins** betterzipql, qlcolorcode, qlmarkdown, qlprettypatch, qlstephen, quicklook-csv, quicklook-json, quicknfo, suspicious-package, webp-quicklook
    + **Color pickers** colorpicker-developer, colorpicker-skalacolo 

- It will aggregate the `iTerm` and `Terminal` themes as prompt you for the name of the color scheme you want to apply and apply it for you
- It will prompt if you would like to run the `.osx` file which contains some system wide modifications and runs it for you.
I recommend that you read the `.osx` file and enable or disable the features that you like. I also create some symlinks there for my Sublime Text 3 configurations and the widgets of Übersicht.

## Updates

Simply run `sh update.sh` and it will take care of the rest




