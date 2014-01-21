module ScreenShare
    module Util
        def notify_user title, message
            system "growl -H localhost -t \"#{title}\" -m \"#{message}\""
        end
    end
end