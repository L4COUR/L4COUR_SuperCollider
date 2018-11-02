
s.boot //start server

q.boot //quit server

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

//TO DO
// - establish MIDI to Moog connection


