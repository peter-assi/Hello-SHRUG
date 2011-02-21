# main_window_controller.rb
# HelloSHRUG
#
# Created by Peter Lind on 2/21/11.
# Copyright 2011 Valtech AB. All rights reserved.
require "rubygems"
require "httparty"
require "digest/md5"


class MainWindowController < NSWindowController
    attr_accessor :url, :button
    
    @@interval = 5
    
    def start_stop(sender)
        NSLog "Button pressed"
        unless @timer
            if @url.stringValue > ""
                NSLog "Starting"
                @uri = @url.stringValue
                @uri = "http://#{@uri}" unless @uri.start_with? "http"
                NSLog "uri set to #{@uri}"

                button.title = "Stop" 
                @timer = NSTimer.scheduledTimerWithTimeInterval(@@interval,
                    target:self, selector:"update_check:", userInfo:nil, repeats:true)                     
            end
        else
            NSLog "Stopping"
            @timer.invalidate
            @timer = nil
            @uri = nil
            @digest = nil
            button.title = "Start"
        end
    end
    
    def update_check(timer)
        NSLog "Checking for update @digest==#{@digest}"
        response = HTTParty.get @uri
        digest = Digest::MD5.hexdigest response.body
        if @digest != digest
            if @digest
                voice = NSSpeechSynthesizer.alloc.initWithVoice("com.apple.speech.synthesis.voice.GoodNews") 
                voice.startSpeakingString "Site is updated"
            end
            @digest = digest
        end
    end
    

end


