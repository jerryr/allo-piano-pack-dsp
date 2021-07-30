#!/bin/bash

rates="96000 88200 48000 44100 192000 176400"
cx=200
destdir="./firmware"
mkdir -p $destdir
packer=$(dirname $0)/pack_dsp.py


function process_file(){
  python3 "$packer" $1 $2
}

for r in $rates
do
rr=$(($r / 1000))
echo "generating firmware for $rr Khz"
file="HPF/base_main_Rate${rr}.cfg"
if [ -f "$file" ]
then
  echo "found $file for tweeter"
  outfile="$destdir/allo-piano-dsp-$r-$cx-0.bin"
  process_file $file $outfile
else 
  echo "FILE $file NOT FOUND!!!!"
fi

file="LPF/base_main_Rate${rr}.cfg"
if [ -f "$file" ]
then
  echo "found $file for woofer"
  outfile="$destdir/allo-piano-dsp-$r-$cx-1.bin"
  process_file $file $outfile
else 
  echo "FILE $file NOT FOUND!!!!"
fi
done
