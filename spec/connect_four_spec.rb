require 'spec_helper'
require 'connect_four'

describe Slot do
  context "when it's initialized without a position" do
    it "raises an error" do
      expect { slot = Slot.new }.to raise_error(StandardError)
    end
  end
  context "when it's initialized with a position" do
  	before do
      @slot = Slot.new(11)
  	end
    it "does not have a color" do
      expect(@slot.color).to eq '-'
    end
    it "has a position" do
      expect(@slot.position).to eq 11
    end
    it "sets a color" do
      @slot.color = "R"
      expect(@slot.color).to eq "R"
    end
  end
end

describe Board do
  context "#generate_board" do
  	before do
      @game_board = Board.new
  	end
    it "is able to be created with a Slot" do
      expect(@game_board.board[0][0].position).to eq 0
    end
    it "can be automatically created" do
      expect(@game_board.board[1][5].position).to eq 15
      expect(@game_board.board[3][2].position).to eq 32
      expect(@game_board.board[6][5].position).to eq 65
    end
  end
  context "#four_in_a_row?" do
    before do
      @game_board = Board.new
      @game_board.board[0][0].color, @game_board.board[1][0].color, @game_board.board[2][0].color, @game_board.board[3][0].color = "R", "R", "R", "R"
      @game_board.board[1][2].color, @game_board.board[2][3].color, @game_board.board[3][4].color, @game_board.board[4][5].color = "R", "R", "R", "R"
      @game_board.board[0][5].color, @game_board.board[1][4].color, @game_board.board[2][3].color, @game_board.board[3][2].color = "R", "R", "R", "R"
      @game_board.board[6][5].color, @game_board.board[6][4].color, @game_board.board[6][3].color, @game_board.board[6][2].color = "R", "R", "R", "R"
    end
    it "recognizes a horizontal win" do
      expect(@game_board.four_in_a_row?('00', "R")).to be true
    end
    it "recognizes a vertical win" do
      expect(@game_board.four_in_a_row?('64', "R")).to be true
    end
    it "recognizes a diagonal win" do
      expect(@game_board.four_in_a_row?('45', "R")).to be true
      expect(@game_board.four_in_a_row?('05', "R")).to be true
    end
    it "recognizes no winner" do
      expect(@game_board.four_in_a_row?('00', "Y")).to be false
    end
  end 
end

describe Player do
  context "#initialize" do
    it "sets player 1 to red" do
      player = Player.new("sam")
      expect(player.color).to eq "R"
    end
    it "sets player 2 to yellow" do
      player = Player.new("frank")
      expect(player.color).to eq "Y"
    end
    it "displays player name" do
      player = Player.new("frank")
      expect(player.name).to eq "frank"
    end
  end
end

describe Gameplay do
  context "#make_move" do
    before do
      @new_game = Gameplay.new
    end
    it "creates a player" do
      expect(@new_game.create_new_player)
    end
  end
end