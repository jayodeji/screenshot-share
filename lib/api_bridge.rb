#This class is to communicate with the image sharing api
#For now the image sharing api will be imgur, but I wanna make this 
#in such a way that we can use whatever service and just plug it in 
#using the config files
module ScreenShare
    class ApiBridge
        @@image_service = nil
        
        class << self
            def init_image_service
                image_service = Config.get 'image_service'

                require_relative "#{image_service}_service" #require the service class

                @@image_service = Object.const_get("ScreenShare::#{image_service.capitalize}Service").new
            end  

            def upload_image image_path
                puts 'Uploading the image'
                @@image_service.send_upload_request image_path
            end

            def get_uploaded_url
                image_url = @@image_service.get_image_url
                if not image_url or image_url.length < 1
                    raise 'Image url is blank'
                end
                image_url
            end
        end
    end

    class ImageService 

        def send_upload_request image_path 
           raise "child class needs to implement this method #{__method__}"
        end

        def get_image_url
            ''
        end
    end
end