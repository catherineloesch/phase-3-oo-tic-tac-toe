class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    def initialize
        @board = [].push(" ") * 9
    end

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] != " "
    end

    def valid_move?(position)
        (0..8).to_a.include?(position) && !position_taken?(position)
    end

    def turn_count
        self.board.filter { |i| i != " "}.length
    end

    def current_player
        x_count = self.board.filter {|i| i == "X"}.length
        o_count = self.board.filter {|i| i == "O"}.length
        x_count > o_count ? "O" : "X" 
    end

    def turn
        puts "Enter a number between 1 and 9 to make your move!"
        index = self.input_to_index(gets.chomp)

        if self.valid_move?(index)
            self.move(index, self.current_player)
        else
            puts "Invalid move! Try again!"
            self.turn
        end

        self.display_board
    end

    def won?
        winning_combination = nil

        WIN_COMBINATIONS.each do |comb|
            if comb.all? {|i| position_taken?(i)} && comb.map {|i| self.board[i]}.uniq.length == 1
                winning_combination = comb
            end
        end

        winning_combination
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
        self.board[self.won?[0]] if self.won?
    end

    def play
        self.turn until self.over?
        puts self.won? ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end