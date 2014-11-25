
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

One element that i use that is not part of Übersicht is [Dateline](https://itunes.apple.com/us/app/dateline/id406119724?mt=12). it is a discrete desktop calendar with support to iCal and other calendar apps. 




