//La Cour's SC Livesetup with External gear//
s.boot //start server
s.quit //quit server

Server.local.options.device = "Scarlett 6i6 USB"; //connect soundcard
ServerOptions.outDevices //show audio sources

MIDIClient.init; //Initialize MIDI source
MIDIClient.destinations; //routing MIDI
n = MIDIOut.new(0); //setting up MIDI channel 1 = (0)

(
r = Routine({
	{
	[60,75,64,86,77,44,66,88].do{
		arg nn;
		n.noteOn(0, nn, 127);
		0.1.wait;
		n.noteOff(0, nn,127);
		0.1.wait;
		};
	}.loop;
}).play;
)

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
	[80,44,66,48,62,62,70,86].do{
		arg nn;
		n.noteOn(0, nn, 127);
		0.8.wait;
		n.noteOff(0, nn,127);
		0.1.wait;
		};
	}.loop;
}).play;
)

r.stop; //stop the Routine
n.allNotesOff(0); //relase all MIDI notes
CmdPeriod.add({(0..127).do{arg n; n.noteOff(0, n)}});

n.control(0, 5, 0); //Portamento CC
n.control(0, 1, [80,44,66,48,62,62,70,86].do); //Assignable output

//TO DO
// - establish MIDI to Moog connection
//P-bind events (pattern library MIDI part II Youtube)


