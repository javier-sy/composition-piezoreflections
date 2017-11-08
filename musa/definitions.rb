puts "...Definitions loaded!"

class Sample
	attr_reader :device, :slice, :category, :labels, :keyvalues
	
	@@bpm = 180.0
	@@barspm = @@bpm / 4.0	
	
	def initialize device, slice, finish, start, category, *labels, **keyvalues
		@device = device
		@slice = slice
		@length = ((finish - start) / 96000.0) / 60.0
		@category = category
		@labels = labels
		@keyvalues = keyvalues
	end
	
	def length
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
	samples << Sample.new(1, 1, 8902592, 8762405, :continous)
	samples << Sample.new(1, 2, 10567186, 9921211, :continous)
	samples << Sample.new(1, 3, 9243278, 8336592, :continous)
	samples << Sample.new(1, 4, 12890911, 12704010, :continous)
	samples << Sample.new(1, 5, 22878014, 22749531, :continous)
	samples << Sample.new(1, 6, 22565919, 22133558, :continous)
	samples << Sample.new(1, 7, 15200312, 15131213, :continous)
	samples << Sample.new(1, 8, 41555091, 41400476, :continous)
	samples << Sample.new(1, 9, 15766330, 15484025, :continous)
	samples << Sample.new(1, 10, 30365622, 29415819, :continous)
	samples << Sample.new(1, 11, 4071345, 3978414, :continous)
	samples << Sample.new(1, 12, 3893816, 3620357, :continous)
	samples << Sample.new(1, 13, 1797709, 1639107, :continous)
	samples << Sample.new(1, 14, 3360318, 3132627, :continous)
	samples << Sample.new(1, 15, 6370798, 6159442, :continous)
	samples << Sample.new(1, 16, 5898953, 5574476, :continous)
	
	# Continuo con ruido regular
	#
	samples << Sample.new(2, 1, 210157, 18634, :continous_and_random_noise)
	samples << Sample.new(2, 2, 316305, 210157, :continous_and_random_noise)
	samples << Sample.new(2, 3, 14013013, 13864450, :continous_and_random_noise)
	samples << Sample.new(2, 4, 709113, 462592, :continous_and_random_noise)
	samples << Sample.new(2, 5, 2307824, 1777626, :continous_and_random_noise)
	samples << Sample.new(2, 6, 3982056, 2950296, :continous_and_random_noise)
	samples << Sample.new(2, 7, 19776864, 19473010, :continous_and_random_noise)
	samples << Sample.new(2, 8, 4996459, 4840747, :continous_and_random_noise)
	samples << Sample.new(2, 9, 16849431, 16466569, :continous_and_random_noise)
	samples << Sample.new(2, 10, 20048558, 19776864, :continous_and_random_noise)
	samples << Sample.new(2, 11, 20729580, 20084753, :continous_and_random_noise)
	samples << Sample.new(2, 12, 13053083, 12890911, :continous_and_random_noise)
	samples << Sample.new(2, 13, 13754896, 13497479, :continous_and_random_noise)
	samples << Sample.new(2, 14, 14019691, 13754896, :continous_and_random_noise)
	samples << Sample.new(2, 15, 15750472, 15157257, :continous_and_random_noise)
	samples << Sample.new(2, 16, 18292414, 17837149, :continous_and_random_noise)

	# Transitorios
	#
	samples << Sample.new(3, 1, 1464854, 1323553, :transients)
 	samples << Sample.new(3, 2, 1777626, 1666393, :transients)
 	samples << Sample.new(3, 3, 2550641, 2307824, :transients)
 	samples << Sample.new(3, 4, 6424422, 6312178, :transients)
 	samples << Sample.new(3, 5, 8366878, 7983832, :transients)
 	samples << Sample.new(3, 6, 10731346, 10614050, :transients)
 	samples << Sample.new(3, 7, 9921211, 9892176, :transients)
 	samples << Sample.new(3, 8, 15157257, 14963529, :transients)
 	samples << Sample.new(3, 9, 15911564, 15750472, :transients)
 	samples << Sample.new(3, 10, 17678845, 17581059, :transients)

 	# Dinámica
 	#
 	samples << Sample.new(4, 1, 1237685, 709113, :dynamics)
 	samples << Sample.new(4, 2, 5903236, 5396835, :dynamics, :base)
 	samples << Sample.new(4, 3, 6312178, 5926215, :dynamics)
 	samples << Sample.new(4, 4, 4364857, 3982056, :dynamics)
 	samples << Sample.new(4, 5, 7634356, 7159061, :dynamics)
 	samples << Sample.new(4, 6, 7771832, 7634356, :dynamics)
 	samples << Sample.new(4, 7, 7983832, 7771832, :dynamics)
 	samples << Sample.new(4, 8, 41864699, 41603356, :dynamics)

 	# Hardcore
 	#
 	samples << Sample.new(5, 1, 14895290, 14678723, :hardcore)
 	samples << Sample.new(5, 2, 14678723, 14446380, :hardcore)
 	samples << Sample.new(5, 3, 14446380, 14096520, :hardcore)
 	samples << Sample.new(5, 4, 13228219, 12378464, :hardcore)
 	samples << Sample.new(5, 5, 15154569, 15009823, :hardcore)
 	samples << Sample.new(5, 6, 15497569, 15154569, :hardcore)
 	samples << Sample.new(5, 7, 15673695, 15497569, :hardcore)
 	samples << Sample.new(5, 8, 16466569, 15886921, :hardcore)
 	samples << Sample.new(5, 9, 17872152, 17600417, :hardcore)
 	samples << Sample.new(5, 10, 18045654, 17872152, :hardcore)
 	
 	samples
end

