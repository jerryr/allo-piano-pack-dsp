## Create DSP Firmware files for Allo Piano 2.1 (PCM5124)

The Allo Piano 2.1 DAC for Raspberry Pi (and other compatible SBCs) runs a pair of PCM5124 DACs in parallel. Each of these DACs can run it's
own DSP chain. Allo's provided firmware files allow you to configure High-pass and Low-pass filters so that you can use them for output to
a pair of tweeter/midrange and a separate pair of subwoofers. Firmware files are provided that select the crossover frequency between
80Hz and 200Hz. 


Though Allo's product pages say you can run your own DSP on the DACs, there is scant documentation on how to actually do so. And what
information is present is actually wrong. It required a fair bit of trial-and-error and reverse-engineering of the provided firmware to 
figure out how it's supposed to work.

Here are the steps to create your own firmware for these DACs:
1. Obtain access to TI's PurePath studio software. 
2. Use the PurePath software to create 2 separate DSP chains. Make sure to select all the supported frequencies in the top-level properties page (96000 88200 48000 44100 192000 176400 Hz are required) *before* you drop any elements on the palette.
2. Save them as two separate projects called "HPF" and "LPF" in the same parent folder (the names are important)
2. Open a terminal and navigate to the parent folder
3. Run the createfw.sh file from this repository. It will create a folder called "firmware" and put the firmware files into it. You'll need to copy them to "/lib/firmware/allo/piano/2.2/"

This will overwrite the existing firmware files for the "200 Hz" crossover frequency. So you'll need to run alsamixer and select "200" as the crossover frequency to test your DSP. Allo's driver 
hardcodes the list of firmware files it will allow you to select, so you cannot create a new file for a new frequency. You can configure the DSP in PurePath the use any crossover, but the filename
must be the same as one of the existing firmware files. In fact you can do anything you please in the DSP program (doesn't even have to implement a crossover), just as long as you keep the filenames the same.
