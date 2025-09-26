# uvm_vip_for_audio_controller


This was an audio controller core by ultra-embedded.All the credits for the design goes to him. (all .v files are his/hers).


The main module has 3 sub-modules, a DAC, SPDIF protocol and I2S protocol.
Along with a FIFO that stores data.

With the limited knowledge of how designs work in 1st yr of M.Tech I am proud of how far I could get by trail and error and some educated guesses. 
However, I now have much more knowledge of those valid ready handshakes and AW, AR, R, W and B channels are similar to AXI the ones used in this module. 
Other than that, I only did coverage in my project, I did not verify the outputs using scoreboard. I wish to implement that later (in c), which will also give me an idea of how UVM and C work together.


