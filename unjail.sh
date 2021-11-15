#!/bin/bash

# set -x
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
DELAY=900 #in secs - how often restart the script

for (( ;; )); do

# проверяем где валик

stchaincli query staking validator $(stchaincli keys show $NICKNAME \
--bech val --address --keyring-backend test) \
--trust-node \
--node `cat "$HOME/.stchaind/config/config.toml" \
| grep -oPm1 "(?<=^laddr = \")([^%]+)(?=\")"` > 1  



if grep -q true 1; then stchaincli tx slashing unjail \
--from=$NICKNAME \
--chain-id=stratos-testnet-3 \
--keyring-backend=test \
--gas="auto" \
--gas-prices="0.5ustos" \
--gas-adjustment=1.5 \
--node `cat "$HOME/.stchaind/config/config.toml" \
| grep -oPm1 "(?<=^laddr = \")([^%]+)(?=\")"` -y

fi


for (( timer=${DELAY}; timer>0; timer-- ))
       do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
done