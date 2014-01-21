require_relative 'util.rb'

module ScreenShare
    class ImageSharer
        include ScreenShare::Util

        def upload_image_files added_files
            begin
                added_files.each do |image_path|
                    #upload the image file to the image service
                    ApiBridge.upload_image image_path
                    #get the url of the uploaded image
                    image_url = ApiBridge.get_uploaded_url

                    if not image_url
                        raise 'Image url is blank'
                    end
                    #save the url to the clipboard
                    Clipboard.copy image_url
                    #notify the user that the image has been uploaded
                    notify_user 'Screenshot Uploaded', "Screenshot #{image_path} uploaded. It is copied on your clipboard"
                end
            rescue Exception => exception 
                notify_user "Error uploading screenshot", exception.message
            end
        end
    end
end