require_relative '../models/game.rb'

class ThrowsController < ApplicationController

  def index
  	game_obj = Game.new
  	@throws = Throw.all
  	@frames = game_obj.calculate_frames @throws
  	@can_throw = game_obj.can_throw?
  end

	def create
		if Throw.count == 0
			@throw = Throw.new({'position' => 1, "pins_down" => params[:throw][:pins_down].to_i })
		else
			last_throw_num = Throw.last.position
			@throw = Throw.new({'position' => last_throw_num+1, "pins_down" => params[:throw][:pins_down].to_i})
		end
		respond_to do |format|
			if @throw.save
				format.html {redirect_to throws_url, notice: "Throw was added successfully"}
			else
				format.html {redirect_to throws_url, notice: "Unsuccessful. Please check again"}
			end
		end
	end

	def destroy
		Throw.destroy_all
		redirect_to throws_url, notice: "New Game Started"
	end

end