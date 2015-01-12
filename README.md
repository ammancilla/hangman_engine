# hangman_engine
Use this library to build your own HANGMAN game in ruby.

## Installation

Run from your command line:
```
$ gem install 'hangman_engine'
```
Then, require it on your file:
```ruby
require 'hangman_engine'
```
## Usage
- Game Flow
All you need to control your Hangman game flow is in `HangmanEngine::Game`. To get started, create a new `HangmanEngine::Game` instace: 

```ruby
# - Parameters
# word: the word to guess.
# allowed_attempts: number of times that the player can guess before losing.
# clue: a clue to the player.
hangman_game = HangmanEngine::Game.new(word, allowed_attempts, clue)
```
After creating a new `HangmanEngine::Game` instance, use his methods to control the game flow (getters and setters are not shown):
```ruby
guess(ltr) # Attempt to guess a letter.
guessed?(ltr) # Determines whether the letter was guessed or not.
remaining_attempts
solved?
lost?
finished?
```
- Game View (Console)
A helper class to help you build a **console based interface** is also included. `HangmanEngine::Drawer` will help you to display a `HangmanEngine::Game` in the console. Available methods are shown bellow:
```ruby
# Dinamically generate the game 'puppet' based on the length of the word to guess and the remaining attempts to guess it.
# 
#  O
# /|\
# / \
#
HangmanEngine::Drawer.draw_puppet(hangman_game)

# Draw the game board based on the word to guess and the guessed letters.
# 
# a _ f o _  _ _
# 
HangmanEngine::Drawer.draw_board(hangman_game)
```
## Examples
List of Hangman games built using this library:
- Play Hangman (https://github.com/ammancilla/play_hangman)