require 'musa-dsl'

include Musa::Series

puts "Score loaded: file loaded"

class Sample
	attr_reader :device, :slice, :length, :labels, :keyvalues
	
	def initialize device, slice, start, finish, *labels, **keyvalues
		@device = device
		@slice = slice
		@length = ((finish - start) / 96000.0) / 60.0
		@labels = labels
		@keyvalues = keyvalues
	end
	
	def bars
		@length * @@barspm
	end
end


def sample device, slice, start, finish, *labels, **keyvalues
	@samples ||= []
	@samples << Sample.new(device, slice, start, finish, *labels, **keyvalues)
end

def definition
	# Continuo
	#
	sample 1, 1, 8902592, 8762405
	sample 1, 2, 10567186, 9921211
	sample 1, 3, 9243278, 8336592
	sample 1, 4, 12890911, 12704010
	sample 1, 5, 22878014, 22749531
	sample 1, 6, 22565919, 22133558
	sample 1, 7, 15200312, 15131213
	sample 1, 8, 41555091, 41400476
	sample 1, 9, 15766330, 15484025
	sample 1, 10, 30365622, 29415819
	sample 1, 11, 4071345, 3978414
	sample 1, 12, 3893816, 3620357
	sample 1, 13, 1797709, 1639107
	sample 1, 14, 3360318, 3132627
	sample 1, 15, 6370798, 6159442
	sample 1, 16, 5898953, 5574476
	
	# Continuo con ruido regular
	#
	sample 2, 1, 210157, 18634
	sample 2, 2, 316305, 210157
	sample 2, 3, 14013013, 13864450
	sample 2, 4, 709113, 462592
	sample 2, 5, 2307824, 1777626
	sample 2, 6, 3982056, 2950296
	sample 2, 7, 19776864, 19473010
	sample 2, 8, 4996459, 4840747
	sample 2, 9, 16849431, 16466569
	sample 2, 10, 20048558, 19776864
	sample 2, 11, 20729580, 20084753
	sample 2, 12, 13053083, 12890911
	sample 2, 13, 13754896, 13497479
	sample 2, 14, 14019691, 13754896
	sample 2, 15, 15750472, 15157257
	sample 2, 16, 18292414, 17837149

	# Transitorios
	#
	sample 3, 1, 1464854, 1323553
 	sample 3, 2, 1777626, 1666393
 	sample 3, 3, 2550641, 2307824
 	sample 3, 4, 6424422, 6312178
 	sample 3, 5, 8366878, 7983832
 	sample 3, 6, 10731346, 10614050
 	sample 3, 7, 9921211, 9892176
 	sample 3, 8, 15157257, 14963529
 	sample 3, 9, 15911564, 15750472
 	sample 3, 10, 17678845, 17581059

 	# Dinámica
 	#
 	sample 4, 1, 1237685, 709113
 	sample 4, 2, 5903236, 5396835
 	sample 4, 3, 6312178, 5926215
 	sample 4, 4, 4364857, 3982056
 	sample 4, 5, 7634356, 7159061
 	sample 4, 6, 7771832, 7634356
 	sample 4, 7, 7983832, 7771832
 	sample 4, 8, 41864699, 41603356

 	# Hardcore
 	#
 	sample 5, 1, 14895290, 14678723
 	sample 5, 2, 14678723, 14446380
 	sample 5, 3, 14446380, 14096520
 	sample 5, 4, 13228219, 12378464
 	sample 5, 5, 15154569, 15009823
 	sample 5, 6, 15497569, 15154569 
 	sample 5, 7, 15673695, 15497569
 	sample 5, 8, 16466569, 15886921
 	sample 5, 9, 17872152, 17600417
 	sample 5, 10, 18045654, 17872152
end

def score s, voices
	s.with do

		at 1 do
			launch :hazlo, 1
		end

		on :hazlo do |pitch|

			pitch = 1 if pitch > 16

			puts "pitch = #{pitch}"

			if pitch < 4
				voices.voice(0).note pitch: pitch, duration: 1

				wait Rational(30, 96) do
					launch :hazlo, pitch + 1
				end

				wait Rational(65, 96) do
					launch :hazlo, pitch + 2
				end
			end
		end
	end
end

