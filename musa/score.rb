require 'musa-dsl'

include Musa::Series

puts "...Score loaded!"

def score sequencer, voices
	
	samples = S()

	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length }.reverse )

	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length }.reverse )

	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :continous_and_random_noise }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )

	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length }.reverse )

	samples = samples.after S(0, 1).repeat.select 	S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length } ),
													S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length } )

	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length } )

	samples = samples.after S(1, 0).repeat.select 	S(*definition.select { |s| s.category == :hardcore }.sort_by { |s| s.length }.reverse ),
													S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )

	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length } )
	samples = samples.after S(*definition.select { |s| s.category == :continous }.sort_by { |s| s.length }.reverse )

	rythm = S(*definition.select { |s| s.category == :dynamics && s.labels.include?(:base)}.sort_by { |s| s.length }.reverse ).repeat

	transients = S(*definition.select { |s| s.category == :transients }.sort_by { |s| s.length} ).repeat

	sequencer.with do

		counter = 0
		counter_end = 0

		sounding = 0
		transient_sounding = 0

		ending = false

		at 1 do
			launch :rythm
		end

		on :rythm do
			counter += 1
			slice = rythm.next_value

			voices.voice(slice.device - 1).note pitch: slice.slice - 1, duration: slice.length

			unless ending && sounding == 0 && counter_end >= 4
				puts "ending = #{ending} sounding = #{sounding} counter = #{counter} counter_end = #{counter_end}"

				wait slice.length * Rational(11, 16) do
					launch :rythm
				end

				if ending && sounding == 0
					counter_end += 1
				end
			end

			if counter == 4
				wait slice.length * Rational(1, 3) do
					launch :play
				end
			end
		end

		on :play do
			slice = samples.next_value
			
			if slice
				voices.voice(slice.device - 1).note pitch: slice.slice - 1, duration: slice.length

				sounding += 1

				wait slice.length do
					sounding -= 1
				end

				case 
				when slice.length > 7
					log "Slice.length > 7"

					wait slice.length * Rational(1, 4) do
						launch :transient 
					end

					wait slice.length * Rational(2, 4) do
						launch :play
					end

					if sounding < 4
						wait slice.length * Rational(3, 4) do
							launch :play 
						end
					else
						log "Overdrive!!!!"
					end
		
				when slice.length > 6
					log "Slice.length > 6"

					wait slice.length * Rational(1, 4) do
						launch :transient
					end

					wait slice.length * Rational(3, 4) do
						launch :play 
					end
					
				when slice.length > 4
					log "Slice.length > 4"

					wait slice.length * Rational(1, 4) do
						launch :transient
					end

					wait slice.length * Rational(2, 4) do
						launch :play 
					end

				when slice.length > 2
					log "Slice.length > 2"

					wait slice.length * Rational(2, 4) do
						launch :play 
					end
				
					wait slice.length * Rational(3, 4) do
						launch :transient
					end

				else
					log "Slice.length... else"

					wait slice.length do
						launch :play
					end
				end
			else
				ending = true
			end
		end

		on :transient do
			if transient_sounding == 0
				transient_sounding += 1
				
				log "Transient"

				transient = transients.next_value
				voices.voice(transient.device - 1).note pitch: transient.slice - 1, duration: transient.length

				wait transient.length do
					transient_sounding -= 1
				end
			end
		end
	end
end

