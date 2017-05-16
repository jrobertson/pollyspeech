#!/usr/bin/env ruby

# file: pollyspeech.rb


require 'aws-sdk'
require 'digest/md5'


class PollySpeech


  def initialize(access_key: '', secret_key: '', region: 'us-east-1', 
                  voice_id: 'Emma', cache_filepath: 'cache')

    @polly = Aws::Polly::Client.new(region: region, 
      credentials: Aws::Credentials.new(access_key, secret_key))
    @voice_id = voice_id
    @cache_filepath = File.join(cache_filepath, voice_id)

  end

  def tts(text='', audiofile_out='/tmp/polly.ogg')

    ext = File.extname(audiofile_out)
    out_format = {'.ogg' => 'ogg_vorbis', '.mp3' => 'mp3'}[ext]

    FileUtils.mkdir_p @cache_filepath
    
    h = Digest::MD5.new << text
    filename = File.join(@cache_filepath, h.to_s + ext)
    
    
    # attempts to find the audio file from a local cache instead of 
    # making a relatively expensive request through the web API
    
    if not File.exists? filename then
            
      @polly.synthesize_speech(response_target: filename, text: text, 
        output_format: out_format,  voice_id: @voice_id)

    end    
    
    FileUtils.cp filename, audiofile_out    

  end

end