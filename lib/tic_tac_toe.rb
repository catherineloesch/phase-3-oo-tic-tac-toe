class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize
        @board = []
        9.times {@board << " "}
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        (user_input.to_i) - 1
    end

    def move(index, token="X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] != " "
    end

    def valid_move?(index) 
        [0,1,2,3,4,5,6,7,8].include?(index) && !position_taken?(index)
    end

    def turn_count
        self.board.filter {|i| i != " " }.length
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Enter a number between 1 and 9 to make your move!"
        user_input = gets.chomp
        index = self.input_to_index(user_input)
        if self.valid_move?(index)
            self.move(index, self.current_player)
        else
            puts "Invalid move!"
            self.turn
        end
        self.display_board
    end

    def won?
         x_indexes = self.board.map.with_index {|e, i| i if e == "X"}.compact
         o_indexes = self.board.map.with_index {|e, i| i if e == "O"}.compact

         x_matches = WIN_COMBINATIONS.find {|w| (x_indexes&w).length == 3}
         o_matches = WIN_COMBINATIONS.find {|w| (o_indexes&w).length == 3}

        if x_matches
            x_matches
        elsif o_matches
            o_matches
        else
            false
        end
    end

    def full?
        !self.board.include?(" ")
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.won? || self.draw?
    end

    def winner
        if self.won?
            self.board[self.won?[0]]
        end
    end

    def play
        self.turn until self.over?
        puts (self.won? ? "Congratulations #{self.winner}!" : "Cat's Game!")
    end
end