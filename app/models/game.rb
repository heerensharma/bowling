#Main class which take data from "Throw" table and 
#Gives back the real-time score of each frame.
class Game
	def initialize()
		@can_throw = true
	end

	#flag which indicates the end of the game
	def can_throw?
		return @can_throw
	end

	#method call to calculate the real-time value of frame for the current throws
	def calculate_frames(throw_data)

		@frames = [0,0,0,0,0,0,0,0,0,0]

		throws = throw_data
		frame_num = 0
		curr_pos=0
		10.times do
			begin
				# puts "Before frameNumber : #{frame_num}"
				#Evaluation of frame where "Strike" occured
				if throws[curr_pos].pins_down == 10
					begin
						@frames[frame_num] = 10+throws[curr_pos+1].pins_down + throws[curr_pos+2].pins_down 
						curr_pos = curr_pos+1
						frame_num+=1
						if frame_num == 10 then @can_throw = false end
						next
					rescue
						@frames[frame_num] = 10
						break
					end
				end
				
				#Evaluation of frame where "Spare" occured
				if throws[curr_pos].pins_down+throws[curr_pos+1].pins_down == 10
					begin
						@frames[frame_num] = (10 + throws[curr_pos+2].pins_down)
						curr_pos+=2
						frame_num+=1
					rescue
						@frames[frame_num] = throws[curr_pos].pins_down
						break
					end	
				
				#Evaluation of frame where neither "Strike" and "Spare" happens i.e.  
				#not all pins can be put down in two trials.	
				else
					@frames[frame_num]= (throws[curr_pos].pins_down+throws[curr_pos+1].pins_down)
					curr_pos+=2
					frame_num+=1
				end
				# puts "After frameNumber : #{frame_num}"
				#this ensures that it is the last frame to evaluate
				# making @can_throw attribute false
				if frame_num == 10
					@can_throw = false	
				end
			rescue
				break
			end 		
		end
		return @frames
	end

	#method to check whether it is valid to accept the inputted value
	def input_score(params)
		accept_flag=true
		if Throw.count == 0
			@throw = Throw.new({'position' => 1, "pins_down" => params[:throw][:pins_down].to_i })
		else
			last_throw_num = Throw.last.position
			@throw = Throw.new({'position' => last_throw_num+1, "pins_down" => params[:throw][:pins_down].to_i})
		end
		#check whether if last shot try was not end up in a Strike,
		#sum of last strike and current strike is not greater than 10 (as there are 10 pins only) 
		begin
			if Throw.last.pins_down != 10 and Throw.last(2).map {|data_row| data_row.pins_down}.inject(:+) != 10
				if (Throw.last.pins_down + params[:throw][:pins_down].to_i) > 10 then accept_flag = false end 
			end
		rescue
			puts "this is most probably will occur when it is the very first throw of the game" 
		end
		return @throw, accept_flag
	end
end