#!/usr/bin/env ruby

# file: pollyspeech.rb


require 'aws-sdk'
require 'digest/md5'
require 'rxfhelper'


class PollySpeech
  include RXFHelperModule
  using ColouredText


  def initialize(access_key: '', secret_key: '', region: 'us-east-1', 
                  voice_id: 'Emma', cache_filepath: 'cache', debug: false)

    @debug = debug
    
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
            
      params = {response_target: filename, text: text, 
        output_format: out_format,  voice_id: @voice_id}
      params.merge!({text_type: 'ssml'}) if text.lstrip =~ /^<speak/
      @polly.synthesize_speech(params)

    end    
    
    puts ('audiofile_out' + audiofile_out.inspect).debug if @debug
    FileX.cp filename, audiofile_out        

  end

end
