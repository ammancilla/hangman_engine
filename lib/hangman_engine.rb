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

    def solved?
      @word.split('').uniq.length == @guesses.length
    end

    def lost?
      remaining_attempts == 0
    end

    def finished?
      solved? || lost?
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
      allowat = hangman_game.allowed_attempts
      rattempts = hangman_game.remaining_attempts
      puppet =  burn_or_body(" O ", allowat, allowat, rattempts) + "\n"
      1.upto(allowat) do |i|
        puppet << case allowat - i
        when 5
          burn_or_body('/', 5, allowat, rattempts)
        when 4
          burn_or_body('|', 4, allowat, rattempts)
        when 3
          burn_or_body("\\", 3, allowat, rattempts) + "\n"
        when 2
          burn_or_body('/', 2, allowat, rattempts) + ' '
        when 1
          burn_or_body("\\", 1, allowat, rattempts) + "\n"
        when 0
          ''
        else
          burn_or_body(" | ", allowat - i, allowat, rattempts) + "\n"
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
    def self.burn_or_body(part, part_number, allowed_attempts, remaining_attempts)
      (allowed_attempts - remaining_attempts) >= part_number ? ' ' : part
    end
  end
end