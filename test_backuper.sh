#!/bin/bash 

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

COUNT=`ls -a ~/backup | wc -l`
~/ramp_up/backuper.sh create
COUNT2=`ls -a ~/backup | wc -l`
echo -e "//////   TEST  1   //////  "
[ "$COUNT" != "$COUNT2" ]; echo -e "${GREEN}OK${NC}" || echo -e "${RED}FAILED${NC}"

~/ramp_up/backuper.sh create file 
echo -e "//////   TEST  2   //////  " 
[ "$?" = "9" ]; echo -e "${GREEN}OK${NC} \n" || echo -e "${RED}FAILED${NC} \n"

~/ramp_up/backuper.sh restore 
echo -e "//////   TEST  3   //////  "
[ "$?" = "9" ]; echo -e "${GREEN}OK${NC}\n" || echo -e "${RED}FAILED${NC}\n"

echo -e "//////   TEST  4   //////  "
~/ramp_up/backuper.sh restore PROJ_2022-06-17_20-43-23
[ -d ./PROJ_2022-06-17_20-43-23/ ]; echo -e "${GREEN}OK${NC}\n" || echo -e "${RED}FAILED${NC}\n"
rm -R -f ./PROJ_2022-06-17_20-43-23/

echo -e "//////   TEST 5   //////  "
~/ramp_up/backuper.sh restore PROJ_2022-06-17_20-43
[ "$?" = "9" ]; echo -e "${GREEN}OK${NC}" || echo -e "${RED}FAILED${NC}"

echo -e "//////   TEST 6   //////  "
~/ramp_up/backuper.sh restore PROJ_2022-06-17_20-43 sdfgh
[ "$?" = "9" ]; echo -e "${GREEN}OK${NC}" || echo -e "${RED}FAILED${NC}"


