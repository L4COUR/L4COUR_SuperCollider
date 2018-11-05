//La Cour's SC Livesetup with External gear//
s.boot //start server
s.quit //quit server

Server.local.options.device = "Scarlett 6i6 USB"; //connect soundcard
ServerOptions.outDevices //show audio sources

MIDIClient.init; //Initialize MIDI source
MIDIClient.destinations; //routing MIDI
n = MIDIOut.new(0); //setting up MIDI channel 1 = (0)

p = ProxySpace.push(s.boot,p);
m = ProxyMixer(p,8);
s.scope //start Oscilloscope



( //Scarlett inputs (Moog Mother 32 & DFAM)
SynthDef("help-AudioIn",{ arg out=0;
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

( // Moog 32 - Sequencer
r = Routine({
	{
	[40,44,60,48,20,63,30,48].do{
		arg nn;
		n.noteOn(0, nn, 127);
		0.1.wait;
		n.noteOff(0, nn,127);
		0.1.wait;
		};
	}.loop;
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
	\midinote, Pxrand([
		[42,54,46,48],
		[66,14,55,87],
		[44,34,68,64],
	],inf),
	\amp, Pwhite(15,30,inf),
	\sustain, 0.5,
	\dur, 0.2

)).play;
)

(
Pdef(\moogcc, Pbind(
	\type, \midi,
	\midicmd, \control,
	\midiout, n,
	\chan, 0,
	\ctlNum, 1,
	\control, Pexprand(1, 50, inf).round,
	\dur, 1/4,

)).play;
)

~moog.stop
~moog_cc1.stop
//TO DO
// - establish MIDI to Moog connection
//P-bind events (pattern library MIDI part II Youtube)


