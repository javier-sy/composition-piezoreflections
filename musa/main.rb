require 'musa-dsl'
require 'unimidi'

input = UniMIDI::Input.all.select { |x| x.name == 'Apple Inc. Driver IAC' }[1]
output = UniMIDI::Output.all.select { |x| x.name == 'Apple Inc. Driver IAC' }[1]

transport = nil

clock = Musa::InputMidiClock.new input
#clock = Musa::DummyClock.new { transport.sequencer.size > 0 }

transport = Musa::Transport.new clock, after_stop: ->{ puts "The End!" }

voices = Musa::MIDIVoices.new sequencer: transport.sequencer, output: output, channels: [0, 1, 2, 3, 4, 5], log: true

transport.before_begin do
	puts "Begin..."
	
	load "./definitions.rb"
	load "./score.rb"

	score transport.sequencer, voices
end

transport.sequencer.on_debug_at do
	log
end 

transport.sequencer.on_fast_forward do |enabled|
	voices.fast_forward = enabled
end

transport.start