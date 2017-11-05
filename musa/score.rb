require 'musa-dsl'

include Musa::Series

puts "Score loaded: file loaded"

class Sample
	attr_reader :device, :slice, :length, :labels, :keyvalues
	
	@@bpm = 240.0
	@@barspm = @@bpm / 4.0	
	
	def initialize device, slice, finish, start, *labels, **keyvalues
		@device = device
		@slice = slice
		@length = ((finish - start) / 96000.0) / 60.0
		@labels = labels
		@keyvalues = keyvalues
	end
	
	def bars
		@length * @@barspm
	end
	
	def to_s
		"device #{device} slice #{slice}"
	end
	
	alias inspect to_s
end

def definition
	samples = []

	# Continuo
	#
	samples << Sample.new(1, 1, 8902592, 8762405)
	samples << Sample.new(1, 2, 10567186, 9921211)
	samples << Sample.new(1, 3, 9243278, 8336592)
	samples << Sample.new(1, 4, 12890911, 12704010)
	samples << Sample.new(1, 5, 22878014, 22749531)
	samples << Sample.new(1, 6, 22565919, 22133558)
	samples << Sample.new(1, 7, 15200312, 15131213)
	samples << Sample.new(1, 8, 41555091, 41400476)
	samples << Sample.new(1, 9, 15766330, 15484025)
	samples << Sample.new(1, 10, 30365622, 29415819)
	samples << Sample.new(1, 11, 4071345, 3978414)
	samples << Sample.new(1, 12, 3893816, 3620357)
	samples << Sample.new(1, 13, 1797709, 1639107)
	samples << Sample.new(1, 14, 3360318, 3132627)
	samples << Sample.new(1, 15, 6370798, 6159442)
	samples << Sample.new(1, 16, 5898953, 5574476)
	
	# Continuo con ruido regular
	#
	samples << Sample.new(2, 1, 210157, 18634)
	samples << Sample.new(2, 2, 316305, 210157)
	samples << Sample.new(2, 3, 14013013, 13864450)
	samples << Sample.new(2, 4, 709113, 462592)
	samples << Sample.new(2, 5, 2307824, 1777626)
	samples << Sample.new(2, 6, 3982056, 2950296)
	samples << Sample.new(2, 7, 19776864, 19473010)
	samples << Sample.new(2, 8, 4996459, 4840747)
	samples << Sample.new(2, 9, 16849431, 16466569)
	samples << Sample.new(2, 10, 20048558, 19776864)
	samples << Sample.new(2, 11, 20729580, 20084753)
	samples << Sample.new(2, 12, 13053083, 12890911)
	samples << Sample.new(2, 13, 13754896, 13497479)
	samples << Sample.new(2, 14, 14019691, 13754896)
	samples << Sample.new(2, 15, 15750472, 15157257)
	samples << Sample.new(2, 16, 18292414, 17837149)

	# Transitorios
	#
	samples << Sample.new(3, 1, 1464854, 1323553)
 	samples << Sample.new(3, 2, 1777626, 1666393)
 	samples << Sample.new(3, 3, 2550641, 2307824)
 	samples << Sample.new(3, 4, 6424422, 6312178)
 	samples << Sample.new(3, 5, 8366878, 7983832)
 	samples << Sample.new(3, 6, 10731346, 10614050)
 	samples << Sample.new(3, 7, 9921211, 9892176)
 	samples << Sample.new(3, 8, 15157257, 14963529)
 	samples << Sample.new(3, 9, 15911564, 15750472)
 	samples << Sample.new(3, 10, 17678845, 17581059)

 	# Dinámica
 	#
 	samples << Sample.new(4, 1, 1237685, 709113)
 	samples << Sample.new(4, 2, 5903236, 5396835, :base)
 	samples << Sample.new(4, 3, 6312178, 5926215)
 	samples << Sample.new(4, 4, 4364857, 3982056)
 	samples << Sample.new(4, 5, 7634356, 7159061)
 	samples << Sample.new(4, 6, 7771832, 7634356)
 	samples << Sample.new(4, 7, 7983832, 7771832)
 	samples << Sample.new(4, 8, 41864699, 41603356)

 	# Hardcore
 	#
 	samples << Sample.new(5, 1, 14895290, 14678723)
 	samples << Sample.new(5, 2, 14678723, 14446380)
 	samples << Sample.new(5, 3, 14446380, 14096520)
 	samples << Sample.new(5, 4, 13228219, 12378464)
 	samples << Sample.new(5, 5, 15154569, 15009823)
 	samples << Sample.new(5, 6, 15497569, 15154569)
 	samples << Sample.new(5, 7, 15673695, 15497569)
 	samples << Sample.new(5, 8, 16466569, 15886921)
 	samples << Sample.new(5, 9, 17872152, 17600417)
 	samples << Sample.new(5, 10, 18045654, 17872152)
 	
 	samples
end

def score sequencer, voices
	score_ok sequencer, voices
end

def score_ok sequencer, voices
	
	samples =  S(*definition.select { |s| s.device == 1 }.sort { |a, b| b.bars <=> a.bars } )  \
		.after(S(*definition.select { |s| s.device == 1 }.sort { |b, a| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 2 }.sort { |a, b| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 2 }.sort { |b, a| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 5 }.sort { |a, b| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 5 }.sort { |b, a| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 2 }.sort { |a, b| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 2 }.sort { |b, a| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 1 }.sort { |a, b| b.bars <=> a.bars } )) \
		.after(S(*definition.select { |s| s.device == 1 }.sort { |b, a| b.bars <=> a.bars } ))

	rythm = S(*definition.select { |s| s.device == 4 && s.labels.include?(:base)}.sort { |a, b| b.bars <=> a.bars } ).repeat


	density = RND(false, false, true).repeat

	sequencer.with do

		index = 0
		ending = false

		at 1 do
			launch :rythm
		end

		on :rythm do
			index += 1
			slice = rythm.next_value

			voices.voice(slice.device - 1).note pitch: slice.slice - 1, duration: slice.bars

			if !ending
				wait slice.bars do
					launch :rythm
				end
			end

			if index == 4
				launch :play
			end
		end

		on :play do
			slice = samples.next_value
			
			if slice
				puts "slice = #{slice}"
	
				voices.voice(slice.device - 1).note pitch: slice.slice - 1, duration: slice.bars
	
				wait slice.bars * Rational(1, 3) do
					launch :play if density.next_value
				end
	
				wait slice.bars * Rational(2, 3) do
					launch :play # if density.next_value
				end
			else
				ending = true
			end
		end

	end
end

