#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

cd ~/test && ~/ramp_up/installer.sh -i ~/backup

echo -e "${PURPLE}INSTALATION${NC}"
[ -e ~/.my-settings-test ]; echo -e "MY-SETTINGS CREATED    ${GREEN}OK${NC} " || echo -e "MY-SETTINGS CREATED ${RED}FAILED${NC}"
[ -e ~/test.tar.gz ]; echo -e "TAR CREATED            ${GREEN}OK${NC} " || echo -e "TAR CREATED ${RED}FAILED${NC}"
[ -d ~/backup/test ]; echo -e "DIR INSTALLED          ${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC}\n"

cd ~/backup/test && ~/ramp_up/installer.sh -r ~/backup
[ "$#" == "1" ]; echo -e "${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC} \n"
cd ~/backup && ~/ramp_up/installer.sh -r ~/backup
[ "$#" == "1" ]; echo -e "${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC} \n"
cd ~/backup/test && ~/ramp_up/installer.sh -r ~/backup123
[ "$#" == "1" ]; echo -e "${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC} \n"

cd ~/backup/test && ~/ramp_up/installer.sh -r ~/Files

echo -e "\n${PURPLE}REINSTALATION${NC}"
[ -e ~/.my-settings-test-old ]; echo -e "MY-SETTINGS-OLD CREATED ${GREEN}OK${NC} " || echo -e "MY-SETTINGS-OLD CREATED ${RED}FAILED${NC}"
[ -e ~/.my-settings-test ]; echo -e "MY-SETTINGS CREATED     ${GREEN}OK${NC} " || echo -e "MY-SETTINGS CREATED     ${RED}FAILED${NC}"
[ -d ~/Files/test ]; echo -e "DIR INSTALLED           ${GREEN}OK${NC} \n" || echo -e "DIR INSTALLED           ${RED}FAILED${NC}\n"

~/ramp_up/installer.sh -u test

echo -e "\n${PURPLE}UNINSTALATION${NC}"
[ ! -e ~/.my-settings-test-old ]; echo -e "MY-SETTINGS REMOVER     ${GREEN}OK${NC} " || echo -e "MY-SETTINGS REMOVER ${RED}FAILED${NC}"
[ ! -e ~/.my-settings-test ]; echo -e "MY-SETTINGS-OLD REMOVER ${GREEN}OK${NC} " || echo -e "MY-SETTINGS-OLD REMOVER ${RED}FAILED${NC}"
[ ! -d ~/backup/test ]; echo -e "DIR REMOVER             ${GREEN}OK${NC} " || echo -e "DIR REMOVER             ${RED}FAILED${NC}"
[ ! -d ~/Files/test ]; echo -e "DIR REMOVER             ${GREEN}OK${NC} \n" || echo -e "DIR REMOVER             ${RED}FAILED${NC}\n"

#Return enviroment
tar -xzf ~/test.tar.gz -C ~ && mv ~/home/anna/backup/test ~/test && rm -R ~/home && rm ~/test.tar.gz

cd ~/test && ~/ramp_up/installer.sh -i 

echo -e "${PURPLE}INSTALATION to ~/local${NC}"
[ -e ~/.my-settings-test ]; echo -e "MY-SETTINGS CREATED    ${GREEN}OK${NC} " || echo -e "MY-SETTINGS CREATED ${RED}FAILED${NC}"
[ -e ~/test.tar.gz ]; echo -e "TAR CREATED            ${GREEN}OK${NC} " || echo -e "TAR CREATED ${RED}FAILED${NC}"
[ -d ~/local/test ]; echo -e "DIR INSTALLED          ${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC}\n"

cd ~/backup/test && ~/ramp_up/installer.sh -r

echo -e "\n${PURPLE}REINSTALATION  to ~/local${NC}"
[ -e ~/.my-settings-test-old ]; echo -e "MY-SETTINGS-OLD CREATED ${GREEN}OK${NC} " || echo -e "MY-SETTINGS-OLD CREATED ${RED}FAILED${NC}"
[ -e ~/.my-settings-test ]; echo -e "MY-SETTINGS CREATED     ${GREEN}OK${NC} " || echo -e "MY-SETTINGS CREATED     ${RED}FAILED${NC}"
[ -d ~/Files/test ]; echo -e "DIR INSTALLED           ${GREEN}OK${NC} \n" || echo -e "DIR INSTALLED           ${RED}FAILED${NC}\n"

#~/ramp_up/installer.sh -u test