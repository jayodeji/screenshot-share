#!/usr/bin/env ruby -KU

require 'listen'
require 'yaml'
require 'json'
require 'base64'
require 'net/http'
require 'net/https'

def upload_to_imgur(added_files)
  added_files.each do |image_path|
    upload_anonymous image_path
    #copy that file was saved
    #copy last file to clipboard
  end  
end

def upload_anonymous(image_path)
  puts "Uploading anonymous"
  request_url = "#{$config['api_endpoint']}image"

  uri = URI.parse(request_url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.path)
  # request.body = JSON.generate({:image => File.open(image_path, 'rb').read})
  request.body = JSON.generate({:image => Base64.encode64(File.read image_path)})
  request['Authorization'] = "Client-ID #{$config['client_id']}"
  response = http.request(request)
  puts response.body
  # response_body = JSON.parse response.body

  request_url
end


#If a config file is included when calling this, use it, 
#otherwise try to use the default config file
#otherwise abort this script with a descriptive message
config_file = ARGV[0]
if not config_file then config_file = 'config/config.yaml' end

$config = YAML.load(File.read(config_file))


#If this is not an anonymous upload
# if not $config['anonymous']
#   $consumer = OAuth::Consumer.new($config['consumer_key'], $config['consumer_secret'], {:site=>"https://api.imgur.com/2"})
#   $access_token = OAuth::AccessToken.from_hash($consumer, {:oauth_token=>$config['oauth_token'], :oauth_token_secret => $config['oauth_token_secret']})
# end


listener = Listen.to($config['listen_to_dir'], only: /\.rb|.png$/) do |modified, added, removed|
  if added.length > 0
    upload_to_imgur added
  end
end
listener.start # not blocking
sleep