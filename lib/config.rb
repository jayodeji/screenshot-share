module ScreenShare
    class Config
    
        @@config = nil

        class << self

            def load_config
                @@config = YAML.load( File.read("#{Dir.pwd}/config/config.yaml") )
            end

            #accessor to get configs
            def get config_name
                if @@config == nil
                    self.load_config
                end
                @@config[config_name]
            end
        end
    end
end