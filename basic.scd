// Boot the server
s.boot;

// Define a basic kick drum
SynthDef(\kick, {
    |out=0|
    var env, osc;
    env = EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
    osc = SinOsc.ar(40, 0, env); // Low sine wave for kick
    Out.ar(out, osc!2);
}).add;

// Define a snare sound
SynthDef(\snare, {
    |out=0|
    var env, noise, snareOsc;
    env = EnvGen.kr(Env.perc(0.005, 0.2), doneAction: 2);
    noise = WhiteNoise.ar(0.3);
    snareOsc = Resonz.ar(noise, 1800, 0.1); // Bandpass filter for snare
    Out.ar(out, (snareOsc * env)!2);
}).add;

// Play the pattern with a simple routine
(
Routine({
    loop {
        // Kick on beat 1
        Synth(\kick);
        0.5.wait;

        // Snare on beat 2
        Synth(\snare);
        0.5.wait;

        // Kick on beat 3
        Synth(\kick);
        0.5.wait;

        // Snare on beat 4
        Synth(\snare);
        0.5.wait;
    }
}).play;
)

