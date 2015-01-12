Gem::Specification.new do |spec|
  spec.name        = 'hangman_engine'
  spec.version     = '0.0.1'
  spec.date        = '2015-01-12'
  spec.summary     = %q(Build your own HANGMAN game!)
  spec.description =
    [
      "Use this library to build your own HANGMAN game.",
      "HangmanEngine::Game have all you need to control the game flow.",
      "HangmanEngine::Drawer will help you to build a console based interface for your HangmanEngine::Game"
    ].join("\n")

  spec.authors     = ["Alfonso Mancilla"]
  spec.email       = ['almancill@gmail.com']
  spec.files       = ["lib/hangman_engine.rb"]
  spec.homepage    = 'https://github.com/ammancilla/hangman_engine'
  spec.license     = 'MIT'
end