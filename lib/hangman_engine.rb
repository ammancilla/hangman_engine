module HangmanEngine

  class GameError < StandardError
  end

  class Game

    attr_reader :word, :clue, :guesses, :attempts, :allowed_attempts

    # Builder
    def initialize(word, allowed_attempts, clue)
      self.word = word.downcase
      self.allowed_attempts = allowed_attempts.to_i
      @clue = clue
      @attempts = 0
      @guesses = []
    end

    # Methods
    def word=(word)
      raise GameError, "word can't be blank" unless word.length > 0
      raise GameError, "word to guess can't have whitespaces. Use only one word." if word.match(/\s/)
      @word = word
    end

    def allowed_attempts=(n)
      raise GameError, "allowed attempts must be greater or equal to the word length (>= #{word.length})." unless n >= word.length
      @allowed_attempts = n
    end

    def guess(ltr)
      if guessed? ltr
        @guesses.push(ltr) unless @guesses.include?(ltr)
      else
        @attempts += 1
      end
    end

    def guessed?(ltr)
      @word.include?(ltr)
    end

    def remaining_attempts
      @allowed_attempts - @attempts
    end

    def won?
      @word.split('').uniq.length == @guesses.length
    end

    def lost?
      remaining_attempts == 0
    end

    def finished?
      won? || lost?
    end
  end

  # Helper class to draw a Hangman::Game on the console
  class Drawer

    # Dinamically generate the game 'puppet' based on the length of the word to guess and the failed guesses count
    # 
    #  O
    # /|\
    # / \
    #
    def self.draw_puppet(hangman_game)
      allowad = hangman_game.allowed_attempts
      attempts = hangman_game.attempts
      puppet =  burn_or_body(" O ", allowad, allowad, attempts) + "\n"
      1.upto(allowad) do |i|
        puppet << case allowad - i
        when 5
          burn_or_body('/', 5, allowad, attempts)
        when 4
          burn_or_body('|', 4, allowad, attempts)
        when 3
          burn_or_body("\\", 3, allowad, attempts) + "\n"
        when 2
          burn_or_body('/', 2, allowad, attempts) + ' '
        when 1
          burn_or_body("\\", 1, allowad, attempts) + "\n"
        when 0
          ''
        else
          burn_or_body(" | ", allowad - i, allowad, attempts) + "\n"
        end
      end
      puppet
    end

    # Draw game board based on the word to guess and the gessues
    # 
    # a _ f o n _ _
    # 
    def self.draw_board(hangman_game)
      board = ''
      hangman_game.word.each_char { |ltr| board << (hangman_game.guesses.include?(ltr) ? "#{ltr} " : '_ ') }
      board
    end
    
    private
    def self.burn_or_body(part, part_number, allowed_attempts, attempts)
      (allowed_attempts - (allowed_attempts - attempts)) >= part_number ? ' ' : part
    end
  end
end