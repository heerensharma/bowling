require_relative '../models/game.rb'

class ThrowsController < ApplicationController

  def index
  	game_obj = Game.new
  	@throws = Throw.all
  	@frames = game_obj.calculate_frames @throws
  	@can_throw = game_obj.can_throw?
  end

	def create
		
		game_obj = Game.new
		@throw, valid_flag = game_obj.input_score params

		respond_to do |format|
			if valid_flag and @throw.save
				format.html {redirect_to throws_url, notice: "Throw was added successfully with value #{Throw.last.pins_down}"}
			else
				format.html {redirect_to throws_url, notice: "Unsuccessful. Please enter a valid value of number of pins down."}
			end
		end
	end

	def destroy
		Throw.destroy_all
		redirect_to throws_url, notice: "New Game Started"
	end

end