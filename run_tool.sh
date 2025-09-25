#!/bin/bash

echo "Welcome to Audio controller VIP:"

echo "Select the desired tool?"
echo "1. Synopsys VCS"
echo "2. Cadence Xcelium"
echo "3. Siemens QuestaSim"

read -t 10 -p "Enter your choice (1, 2, or 3): " choice

echo "Select the test to run:"
echo "1. ALL"
echo "2. I2S test"
echo "3. SPDIF test"
echo "4. DAC test"

read -t 10 -p "Enter your choice: " test1

case $test1 in
  1)
    echo "Running ALL Test...."
    make -f Makefile.vcs TEST=audio_main_test
    ;;
  2)
    echo "Running I2S test...."
	make -f Makefile.vcs TEST=audio_i2s_test
    ;;
  3)
    echo "Running Siemens QuestaSim..."
    make -f Makefile.vcs TEST=audio_spdif_test
    ;;
  4)
  	echo "Running Siemens QuestaSim..."
    make -f Makefile.vcs TEST=audio_dac_test
    ;;
  *)
    echo "Select from options given above."
    ;;
esac


case $choice in
  1)
    echo "Running Synopsys VCS..."
    make -f Makefile.vcs TEST=audio_i2s_test
    ;;
  2)
    echo "Running Cadence Xcelium..."
    make -f Makefile.xcelium
    ;;
  3)
    echo "Running Siemens QuestaSim..."
    make -f Makefile.questa
    ;;
  *)
    echo "Select from options given above."
    ;;
esac

