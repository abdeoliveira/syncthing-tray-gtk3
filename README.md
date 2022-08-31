# syncthing-tray-gtk3
Yet another Syncthing tray icon indicator

It is pretty simple. This code intends to monitor the state of synced local folders and if *one* remote device is connected. There are 4 Syncthing states, each one corresponding to a specific tray icon:

* Icon Alert: Syncthing server is not running.
* Icon Close: Syncthing server is running and remote device is not connected.
* Icon Refresh: Syncthing server is running, remote device is connected and it is syncing.
* Icon Apply: Syncthing server is running, remote device is connected and it is idle.

# Dependencies

sudo apt install ruby

sudo gem install gtk3 net-ping net-http

# Configuration

You must edit the indicated first lines with you API key, remote device ID, and local synced folders ID.

# Usage
ruby syncthing-tray-gtk3.rb

or
 make it executable firsrt: 
 
 chmod +x syncthing-tray-gtk3.rb
 
 and then execute it as
 
 ./syncthing-tray-gtk3.rb
