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
#### Game Flow

 All you need to control your Hangman game flow is in `HangmanEngine::Game`. To get started, create a new instace: 

```ruby
# - Parameters
# word: the word to guess.
# allowed_attempts: number of attempts the player has to solve the game before losing.
# clue: short helper text for the player.
hangman_game = HangmanEngine::Game.new(word, allowed_attempts, clue)
```
 After creating a `HangmanEngine::Game` instance, use its methods to control the game flow (getters and setters are not shown):
```ruby
guess(ltr) # attempts to guess a letter.
guessed?(ltr) # determines whether the given letter was guessed or not.
remaining_attempts
solved? 
lost? # determines if the player has lost.
finished? # determines whether the game was solved or if the player has lost.
```
#### Game View

A helper class to help you build a **console interface** for the game is also included. `HangmanEngine::Drawer` is going to help you to display a `HangmanEngine::Game` in the console. Available methods are:
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
