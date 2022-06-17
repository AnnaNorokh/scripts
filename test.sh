#!/bin/bash

cd ~/test && ./home/anna/ramp_up/installer.sh install ~/backup
echo " "
echo " Instalation"
[ -e ~/.my-settings-test ]; echo "Passed" || echo "FAILED"
[ -e ~/test.tar.gz ]; echo "Passed" || echo "FAILED"
[ -d ~/backup/test ]; echo "Passed" || echo "FAILED"

# cd ~/backup/test && ./home/anna/ramp_up/installer.sh reinstall ~/Files
# echo " "
# echo " REinstalation"
# [ -e ~/.my-settings-test-old ]; echo "Passed" || echo "FAILED"
# [ -e ~/.my-settings-test ]; echo "Passed" || echo "FAILED"
# [ -d ~/Files/test ]; echo "Passed" || echo "FAILED"

./home/anna/ramp_up/installer.sh uninstall test
echo " "
echo "Uninstalation"
[ ! -e ~/.my-settings-test-old ]; echo "Passed" || echo "FAILED"
[ ! -e ~/.my-settings-test ]; echo "Passed" || echo "FAILED"
[ ! -d ~/Files/test ]; echo "Passed" || echo "FAILED"
[ ! -d ~/Files/test ]; echo "Passed" || echo "FAILED"