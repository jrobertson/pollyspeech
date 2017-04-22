# Using the PollySpeech gem

    require 'pollyspeech.rb'


    polly = PollySpeech.new(access_key: '[ACCESS_KEY]', 
                        secret_key: '[SECRET_KEY]', voice_id: 'Emma')
    polly.tts 'Can I help you with anything?', '/tmp/greeting.ogg'

Note: British voice options are Emma, Amy, or Brian

## Resources

* pollyspeech https://rubygems.org/gems/pollyspeech

aws amazon tts polly speech
