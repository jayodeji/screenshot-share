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

def upload_to_imgur(added_files)
  added_files.each do |image_path|
    image_url = upload_anonymous image_path
    Clipboard.copy image_url
  end  
end

def upload_anonymous(image_path)
  puts "Uploading anonymous"
  authorization = "Client-ID #{$config['client_id']}"
  image_url = upload_image image_path, authorization

  image_url
end

def upload_image(image_path, authorization)
  params = { 'image' => Base64.encode64(File.open(image_path, 'rb').read) }
  request_url = "#{$config['api_endpoint']}image"

  res = make_post_request request_url, params, authorization
  image_url = res['data']['link']

  if not image_url
    puts 'an error occurred'
    return
  end

  image_url
end

#make post requests
def make_post_request(request_url, params, authorization)
  begin
    uri = URI.parse(request_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)

    if authorization
      request['Authorization'] = authorization
    end

    response = https.request(request)  
    res = JSON.parse(response.body)
  rescue Exception => exception 
    log exception.message
  end  
  
  res
end

def log(text)
  puts text
end

ScreenShare::Config.load_config #initialize the config
ScreenShare::ApiBridge.init_image_service

listen_to_dir = ScreenShare::Config.get 'listen_to_dir'
listener = Listen.to($config[listen_to_dir], only: /\.rb|.png$/) do |modified, added, removed|
  if added.length > 0
    upload_to_imgur added
  end
end
listener.start # not blocking
sleep