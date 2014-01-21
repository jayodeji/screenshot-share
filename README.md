screenshot-share
================

A simple Ruby app, to watch changes to screenshot directory and auto-upload all screenshots to an image sharing service
for example imgur and copy the link in clipboard for easy sharing.

There is added support for ruby-growl. Ruby-growl does not need growl to be installed, it should work as is out of the
box.

By default, the app watches for new files that end in *.png 


GEM Dependencies
================

- listen
- json
- clipboard
- ruby-growl

These gems are in the Gemfile.

Configuration Options
======================
listen_to_dir: 'xxx' --> This is the full path to the directory that the app should listen to

image_service: 'imgur' --> Which image service to use. By default it uses imgur, but for developers, this can easily be changed

anonymous: 1 --> Whether to use authentication or anonymous, by default it uses anonymous

client_id: 'xxx' --> Client id
client_secret: 'xxx' --> Client secret

This above two configurations are the imgur client_id and client_secret. Make sure you hae an account with
imgur. Then go to this link : http://imgur.com/account/settings/apps, and get your client_secret and client_id

api_endpoint: 'https://api.imgur.com/3/'
For imgur, this endpoint does not need to change


Usage
================
- in the config folder, copy the config.yaml.sample to a config.yaml file, after this action, the config folder should have two files. config.yaml.sample and config.yaml

- Run bundle install to install all the required gems.
- Edit the config file with the appropriate information
- Run ruby main.rb 


If you want to install the free mac version of growl, you can go to the following
http://growl.info/downloads
1.2.2 is free

Before running the ruby main.rb, try to run the ruby growl by : growl -H localhost -m 'testing'
If ruby-growl is not working, go to the following website:
http://bbrinck.com/post/73830054/getting-ruby-growl-to-work


Orginally forked from https://github.com/saadullahsaeed/screenshot-share
Email: joshua.a.adeyemi@gmail.com


