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
                @@image_service.test_service
            end  

            def upload_image 
            end
        end
    end

    class ImageService 

        def test_service 
            puts 'testing'
            raise 'hell'
        end
    end
end