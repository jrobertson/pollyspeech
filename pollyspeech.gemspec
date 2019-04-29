Gem::Specification.new do |s|
  s.name = 'pollyspeech'
  s.version = '0.2.1'
  s.summary = 'A wrapper  of the aws-sdk-polly gem which caches audio files locally. ' + 
      'Defaults to a British voice and OGG format.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/pollyspeech.rb']
  s.add_runtime_dependency('aws-sdk', '~> 2.9', '>=2.9.11')
  s.signing_key = '../privatekeys/pollyspeech.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/pollyspeech'
end
