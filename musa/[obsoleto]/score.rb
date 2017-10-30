require 'musa-dsl'

include Musa::Series

puts "Score loaded: file loaded"

@@bpm = 200
@@barspm = @@bpm / 4.0

def dsize device, slice, start, finish
	@dsize ||= {}
	@dsize[device] ||= {}
	@dsize[device][slice] = ((finish - start) / 96000.0) / 60.0
end

def bars_of device, slice
	@dsize[device][slice] * @@barspm if @dsize[device][slice]
end

def definition_length
	dsize 1, 1, 18634, 210157
	dsize 1, 2, 210157, 316305
	dsize 1, 3, 316305, 462592
	dsize 1, 4, 462592, 709113
	dsize 1, 5, 709113, 1237685
	dsize 1, 6, 1323553, 1464854
	dsize 1, 7, 1487121, 1666393
	dsize 1, 8, 1666393, 1777626
	dsize 1, 9, 1777626, 2307824
	dsize 1, 10, 2307824, 2550641
	dsize 1, 11, 2550641, 2816073
	dsize 1, 12, 2816073, 2950296
	dsize 1, 13, 2950296, 3982056
	dsize 1, 14, 3982056, 4364857
	dsize 1, 15, 4364857, 4840747
	dsize 1, 16, 4840747, 4996459
	dsize 1, 17, 4996459, 5396835
	dsize 1, 18, 5396835, 5903236
	dsize 1, 19, 5926215, 6312178
	dsize 1, 20, 6312178, 6424422
	dsize 1, 21, 6424422, 7159061
	dsize 1, 22, 7159061, 7634356
	dsize 1, 23, 7634356, 7771832
	dsize 1, 24, 7771832, 7983832
	dsize 1, 25, 7983832, 8366878
	dsize 1, 26, 8552047, 8762405
	dsize 1, 27, 8762405, 8902592
	dsize 1, 28, 8902592, 9892176
	dsize 1, 29, 9892176, 9921211
	dsize 1, 30, 9921211, 10567186
	dsize 1, 31, 10567186, 11063365
	dsize 1, 32, 11063365, 11502487
	dsize 1, 33, 11461268, 11966836
	dsize 1, 34, 12088602, 12704010
	dsize 1, 35, 12704010, 12890911
	dsize 1, 36, 12890911, 13053083
	dsize 1, 37, 13053083, 13497479
	dsize 1, 38, 13497479, 13754896
	dsize 1, 39, 13754896, 14019691
	dsize 1, 40, 14019691, 14325440
	dsize 1, 41, 14324538, 14793675
	dsize 1, 42, 14793675, 14963529
	dsize 1, 43, 14963529, 15157257
	dsize 1, 44, 15157257, 15750472
	dsize 1, 45, 15750472, 15911564
	dsize 1, 46, 15911564, 16493198
	dsize 1, 47, 16493198, 17320055
	dsize 1, 48, 17320055, 17609402
	dsize 1, 49, 17581059, 17678845
	dsize 1, 50, 17678845, 17837149
	dsize 1, 51, 17837149, 18292414
	dsize 1, 52, 18327459, 19468163
	dsize 1, 53, 19473010, 19776864
	dsize 1, 54, 19776864, 20048558
	dsize 1, 55, 20084753, 20729580
	dsize 1, 56, 20729580, 21112869
	dsize 1, 57, 21112869, 21752364
	dsize 1, 58, 21752364, 22171356
	dsize 1, 59, 22171356, 22466104
	dsize 1, 60, 22466104, 22749531
	dsize 1, 61, 22749531, 22878014


	
end

def z(device, slice)
	{ device: device, slice: slice, duration: bars_of(device, slice) }
end

def definition
	definition_length

	# Drones simples con algo de chisporreteo
	@a = [ z(1,27), z(1,35), z(1,36), z(1,1), z(1,2), z(1,3), z(1,4), z(1,9), z(1,30), z(1,31), z(1,61) ]

	# Dron simple con algún ruido simple
	@b1 = [ z(1,28), z(1,16), z(1,17), z(1,7), z(1,8), z(1,10), z(1,11), z(1,12) ]
	@b2 = [ z(1,20), z(1,29) ] # muy cortos

	# Dron simple con ruido complejo
	@c = [ z(1,38), z(1,39), z(1,14), z(1,15) ]

	# Dron doble complejo, con subija [y bajada], [base rítmica]
	@d1 = [ z(1,32), z(1,5), z(1,18), z(1,22), z(1,19) ]
	@d2 = [ z(1,33) ]

	# Dron simple, con ruido
	@e = [ z(1,34), z(1,21) ]

	# Dron simple [subiendo y ] bajando
	@f = [ z(1,23), z(1,24), z(1,26), z(1,37) ]

	# Chisporreteo complejo con batido de alas
	@g = [ z(1,6) ]

	# Dron complejo, con subidas y bajadas y ruidos
	@h = [ z(1,13) ]

	# Dron complejo con ruido y dron agudo al final
	@i = [ z(1,40) ]

	# Dron doble (uno agudo)
	@j1 = [ z(1,41), z(1,44), z(1,50) ]
	@j2 = [ z(1,51), z(1,52), z(1,53), z(1,54), z(1,55) ] # con chisporreteo o ruido rítmico (distinguir entre ritmo simple y complejo)

	# Triple dron (uno agudo) y batido de alas periódico
	@k1 = [ z(1,42), z(1,45), z(1,46), z(1,47), z(1,60) ]
	@k2 = [ z(1,48) ] # con ruido

	# Triple dron (uno agudo) y ruido complejo (roce)
	@l1 = [ z(1,49) ]
	@l2 = [ z(1,43) ]

	# Ruido roce con dron ligero
	@m = [ z(1,25) ]
end

def channel(device)
	device - 1
end

def pitch(slice)
	slice + 35
end

def score s, voices
	s.with do 
		definition
		puts "Definition loaded"

		y = S(*@d2).repeat(4)

		while v = y.next_value
			puts "v = #{v}"
		end
		
		at 1 do

			log

			x = S(*@d1).repeat(4)

			play x do |n| 
				log "0: device = #{n[:device]} slice = #{n[:slice]}"
				voices.voice(channel(n[:device])).note pitch: pitch(n[:slice]), duration: n[:duration]
			end

		end
=begin
		at 1 do

			log

			x = S(*@e).repeat(4)

			play x do |n| 
				log "A: device = #{n[:device]} slice = #{n[:slice]}"
				voices.voice(channel(n[:device])).note pitch: pitch(n[:slice]), duration: n[:duration]
			end

		end

		at 2 do

			log

			x = S(*@a)

			play x do |n| 
				log "B: device = #{n[:device]} slice = #{n[:slice]}"
				voices.voice(channel(n[:device])).note pitch: pitch(n[:slice]), duration: n[:duration]
			end

		end
=end
	end
end

