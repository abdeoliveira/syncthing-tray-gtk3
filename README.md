# Unmaintained
This project is no longer active. If you want to use it please consider fork and maintain yourself.

# syncthing-tray-gtk3
Yet another Syncthing tray icon indicator.

It is pretty simple. This code intends to monitor the state of synced local folders and  *one* remote device. There are 4 Syncthing states, each one corresponding to a specific tray icon:

* Icon Alert: Syncthing server is not running.
* Icon Close: Syncthing server is running and remote device is not connected.
* Icon Refresh: Syncthing server is running, remote device is connected and it is syncing.
* Icon Apply: Syncthing server is running, remote device is connected and it is idle.

# Dependencies

`sudo apt install ruby`

`gem install gtk3 net-ping net-http`

# Configuration

You must edit the indicated first lines of the `api_call` function inside `syncthing-tray-gtk3.rb` code with your `API key`, `remote device ID`, and `local synced folders ID`. Also, you may need to edit the server address and refresh rate monitoring (in seconds). The corresponding lines are:

`refresh_rate = 10 #seconds`

`server_address = 'http://localhost:8384'`

# Usage

Run the script with `ruby syncthing-tray-gtk3.rb`. Alternatively, you can make it executable firsrt with `chmod +x syncthing-tray-gtk3.rb`. Then execute it as `./syncthing-tray-gtk3.rb`.
