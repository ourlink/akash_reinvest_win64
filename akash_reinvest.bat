@echo off
SETLOCAL
:: ####  processing variables that can be changed
set akash_validator=akashvaloper...
set key_address=akash...
set key_name=my_demo
set /A reserve_amt=5000000
set /A threshold_amt=2000000

:: ####  do not change any of the below settings unless directed ####
set /A akash_precision=1000000
set akash_chain_id=akashnet-2
set rpc_node=http://135.181.60.250:26657
set /A delay_secs=15

::###--  Start Processing Here -- ###
::# log some initial entries about the execution
CALL :log_data " ---------------------------------------------------- " 
CALL :log_data " The Akash Reinvest application has started           " 

::# Check and withdraw any commissions & rewards 
CALL :log_data " - Withdraw Rewards and Commissions Balances          " 
CALL :withdraw_rewards withdraw_hash 
CALL :log_data " -- Transaction Hash is - " %withdraw_hash%

::# Check Wallet Balance for Amounts sufficient to Delegate
CALL :log_data " - Checking Wallet Balance                            " 
CALL :wallet_balance akash_value

::# calculate values
set /A akash_decimals=%akash_value% %% %akash_precision%
set /A akash_net=((( %akash_value% / %akash_precision% )* %akash_precision% ) - %reserve_amt%)

::# echo the value to the console
CALL :log_data " -- Reserve Amount -  " %reserve_amt% 
CALL :log_data " -- Wallet Balance -  " %akash_value%
CALL :log_data " -------- decimals --    " %akash_decimals%
CALL :log_data " ----- Net Balance -  " %akash_net%

::# Delegate Net Balance to Validator
::# only delegate if amount >= than threshold_amt
if %akash_net% LSS %threshold_amt% GOTO :NOBAL
CALL :log_data " - Delegate Net Wallet Balance to Validator          "
set akash_amt=%akash_net%uakt
CALL :delegate_net delegation_hash
CALL :log_data " --- Delegation Hash is - " %delegation_hash%
CALL :log_data " --- Amount Delegated   - " %akash_amt%
GOTO :END

:NOBAL
CALL :log_data " - Insufficient Wallet Balance to Delegate "

:END
CALL :log_data " The Delegation Reinvestment Process has Completed!   "
CALL :log_data " ---------------------------------------------------- "
EXIT /B 0

:log_data
::{
  set log_date=%DATE%-%TIME%
  echo %log_date% %~1 %~2
  EXIT /B 0
::}

:withdraw_rewards
::{
  ::# withdraw the given amount
  for /f %%i in ('akash.exe tx distribution withdraw-rewards %akash_validator% --fees 5000uakt --from %key_name% --keyring-backend test --keyring-dir .\keys --node %rpc_node% --chain-id %akash_chain_id%  --yes ^| jq-win64 -r ".txhash"') do set withdraw_hash=%%i
  timeout %delay_secs% > NUL
  set "%~1 = %withdraw_hash%"
  EXIT /B 0
::}

:wallet_balance
::{
  ::# get the akash value we have in the wallet
  for /f %%i in ('akash.exe query bank balances %key_address% --node %rpc_node% -o json ^| jq-win64 -r ".balances[0].amount"') do set akash_value=%%i
  timeout %delay_secs%-10 > NUL
  set "%~1 = %akash_value%"
  EXIT /B 0
::}

:delegate_net
::{
  ::# delegate the given amount
  for /f %%i in ('akash.exe tx staking delegate %akash_validator% %akash_amt% --from %key_name% --fees 5000uakt --chain-id %akash_chain_id% --keyring-dir .\keys --keyring-backend test --node %rpc_node% --yes ^| jq-win64 -r ".txhash"') do set delegation_hash=%%i
  timeout %delay_secs% > NUL
  set "%~1 = %delegation_hash%"
  EXIT /B 0
::}

ENDLOCAL