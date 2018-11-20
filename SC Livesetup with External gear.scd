//La Cour's SC Livesetup with External gear//
s.boot //start server
s.quit //quit server

Server.local.options.device = "Scarlett 6i6 USB"; //connect soundcard
ServerOptions.outDevices //show audio sources

MIDIClient.init; //Initialize MIDI source
MIDIClient.destinations; //routing MIDI
n = MIDIOut.new(0); //setting up MIDI channel 1 = (0)
// 0 = running ableton using the IAC bus
// 1 = running supercollider standalone


p = ProxySpace.push(s.boot,p);
m = ProxyMixer(p,8);
s.scope //start Oscilloscope



( //Scarlett inputs (Moog Mother 32 & DFAM)
SynthDef("help-AudioIn",{ arg out=0, pan=0;
	Out.ar(out,
		AudioIn.ar([1,1]) //Input 1 (stereo)
	)
}).play;

SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar([2,2]) //Input 2 (stereo)
	)
}).play;
)

r.stop; //stop the Routine
n.allNotesOff(0); //relase all MIDI notes
CmdPeriod.add({(0..127).do{arg n; n.noteOff(0, n)}});

( //P-bind sequencer
Pdef(\moog, Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, n,
	\chan, 0,
	\midinote, Pseq([74, 47, 74, 25, 74, 46, 74,55], inf)+14,
	\amp, 1,
	\sustain, 0.75,
	\dur, 0.18,
	\pan, Pwhite(-0.8, 0.8, inf),

)).play;
)

(
Pdef(\moogcc, Pbind(
	\type, \midi,
	\midicmd, \control,
	\midiout, n,
	\chan, 0,
	\ctlNum, 1,
	\control, Pseq([60,44,60,48,70,53,60,48], inf),
	\sustain, 0.24,
	\dur, 0.28,

)).play;
)

~moog.stop
~moog_cc1.stop
//TO DO
// - establish MIDI to Moog connection
//P-bind events (pattern library MIDI part II Youtube)


