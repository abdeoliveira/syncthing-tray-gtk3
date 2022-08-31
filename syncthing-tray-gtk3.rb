#!/usr/bin/ruby

require 'gtk3'
require 'json'
require 'uri'
require 'net/http'
require 'net/ping'

refresh_rate = 10 #seconds
server_address = 'http://localhost:8384' 

def ping_api(host)
    check = Net::Ping::HTTP.new(host)
    return check.ping?
end

def api_call(server,endpoint)
      apikey = 'PUT-YOUR-API-KEY-HERE'
      device = 'PUT-YOUR-DEVICE-ID-HERE'
      folders = ['FOLDER-1-ID','FOLDER-2-ID','FOLDER-N-ID']
      url = URI(server + '/rest/' + endpoint)
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Get.new(url)
      request["X-API-Key"] = apikey
      response = http.request(request)
      json=JSON.parse(response.read_body)
      if endpoint == 'events'
        found = Hash.new
        sync = Hash.new
        folders.each do |f|
            found[f]=false
            sync[f]=false
        end
          n = json.length
          n.times do |j|
            l = -j-1
            if json[l]['type']=='FolderCompletion'
              p = json[l]['data']['completion']
              f = json[l]['data']['folder']
              unless found[f] 
                if p < 100 then sync[f] = true end
              end
              found[f]=true
            end
            break unless found.has_value? false
          end  
          if sync.has_value? true
            return true
          else
            return false
          end
      end
      if endpoint == 'system/connections'
          return json['connections'][device]['connected']
      end
end

si = Gtk::StatusIcon.new
si.stock = Gtk::Stock::CLOSE
menu = Gtk::Menu.new
quit = Gtk::ImageMenuItem.new(:label => "Quit", :stock_id => Gtk::Stock::QUIT)
quit.signal_connect('activate'){ Gtk.main_quit }
menu.append(quit)
menu.show_all

si.signal_connect('popup-menu') do |icon, button, time|
  menu.popup(nil, nil, button, time)
end

GLib::Timeout.add(refresh_rate*1000) do
  if ping_api(server_address)
    events_syncing  = api_call(server_address,'events')
    device_connected  = api_call(server_address,'system/connections')
    if device_connected then  
      si.stock = Gtk::Stock::APPLY
      if events_syncing then si.stock  = Gtk::Stock::REFRESH end
    else
      si.stock  = Gtk::Stock::CLOSE  
    end
  else
      si.stock = Gtk::Stock::DIALOG_WARNING
  end
    true
end
Gtk.main

