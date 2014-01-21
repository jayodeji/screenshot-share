#!/usr/bin/env ruby -KU

require 'listen'
require 'yaml'
require 'json'
require 'base64'
require 'net/http'
require 'net/https'
require 'clipboard'

require_relative 'lib/config.rb'
require_relative 'lib/api_bridge.rb'
require_relative 'lib/screen_share.rb'


ScreenShare::Config.load_config #initialize the config
ScreenShare::ApiBridge.init_image_service #initialize the image service to use to upload images

image_uploader = ScreenShare::ImageSharer.new

listen_to_dir = ScreenShare::Config.get 'listen_to_dir'
listener = Listen.to(listen_to_dir, only: /\.png$/) do |modified, added, removed|
  if added.length > 0
    image_uploader.upload_image_files added
  end
end
listener.start # not blocking
sleep