module ScreenShare
    class ImgurService < ImageService
        
        def initialize 
            if Config.get('anonymous') == 1
                @authorization = "Client-ID #{Config.get('client_id')}"
            end
        end

        def send_upload_request image_path 
            @image_path = image_path
            params = get_upload_params
            request_url = "#{Config.get('api_endpoint')}image"
            @res = make_post_request request_url, params, @authorization
        end

        def get_upload_params 
            { 'image' => Base64.encode64(File.open(@image_path, 'rb').read) }
        end

        #make post requests
        def make_post_request(request_url, params, authorization)
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
          res
        end

        def get_image_url
          @res['data']['link']
        end
    end
end