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
			if frame_num != 9 
				begin
					if throws[curr_pos].pins_down == 10
						begin
							@frames[frame_num] = 10+throws[curr_pos+1].pins_down + throws[curr_pos+2].pins_down 
							curr_pos = curr_pos+1
							frame_num+=1
							next
						rescue
							@frames[frame_num] = 10
							break
						end
					end
					
					if throws[curr_pos].pins_down+throws[curr_pos+1].pins_down == 10
						begin
							@frames[frame_num] = (10 + throws[curr_pos+2].pins_down)
							curr_pos+=2
							frame_num+=1
						rescue
							@frames[frame_num] = throws[curr_pos].pins_down
							break
						end	
						
					else
						@frames[frame_num]= (throws[curr_pos].pins_down+throws[curr_pos+1].pins_down)
						curr_pos+=2
						frame_num+=1
					end	
				rescue
					break
				end 
				
			else
				begin
					if throws[curr_pos].pins_down == 10 or 
							(throws[curr_pos].pins_down + throws[curr_pos+1].pins_down) == 10
						@frames[frame_num] = throws[curr_pos].pins_down+throws[curr_pos+1].pins_down+
																		throws[curr_pos+2].pins_down	
					else
						@frames[frame_num] = throws[curr_pos].pins_down+throws[curr_pos+1].pins_down
					end
					# puts "We are in last frame"
					@can_throw=false			
				rescue
					break
				end
			end	
		end
		return @frames
	end
end