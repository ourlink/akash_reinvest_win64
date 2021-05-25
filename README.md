# Akash Reinvest Script (Windows 64) #

----------
## Overview ##
This is a batch file that is designed to work with the **Akash Network** and a local Akash Wallet. 

Using the **Windows Task Scheduler** this batch file can be used to enable the automated withdrawal of Staked Rewards and Reinvestment of these Rewards with an operating Validator on the Akash Network.

## Usage ##
*Ensure all of the **configuration steps** have been completed before attempting to run the batch script.*

To run the script just open a Command Window and run the batch File. 

    akash_reinvest.bat

Your output should look similar to the following;

![](https://i.imgur.com/0QnXSYv.png)

If you do not have a sufficient balance for the re-staking to occur this will be the results the script will produce;

![](https://i.imgur.com/lDi6mGu.png)

A few quick notes;

1. The script always generates re-staking amount in whole integers
2. The script can take up to 45 seconds to execute due to timeout delays
3. You can run the script as frequently as you want, just be aware that you get charged 2 sets of fees each time the script executes - One fee to **Withdraw** your rewards, and another fee to **Delegate/Restake** your rewards.

## Configuration Steps ##
To configure your machine for executing this batch script you need to complete each of the steps below;

### Install JQ for Windows ###
**What is jq** - jq is like `sed` for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.

**Step 1** - Visit the jq download page - [https://stedolan.github.io/jq/download/](https://stedolan.github.io/jq/download/) and download the latest version of jq-win64.exe for windows.

**Step 2** - Place the downloaded `jq-win64.exe` file into a directory that is contained within your local environment's path statement. 



### Akash Installation ###
This will install the Akash binaries onto your local Windows machine;

**Step 3** - Visit the Akash GitHub site ( [https://github.com/ovrclk/akash/releases/latest](https://github.com/ovrclk/akash/releases/latest) ) and download the latest version of the Akash software for Windows. At the present time the latest version is v0.12.1 and the direct link to the Windows Version is here - [https://github.com/ovrclk/akash/releases/download/v0.12.1/akash_0.12.1_windows_amd64.zip](https://github.com/ovrclk/akash/releases/download/v0.12.1/akash_0.12.1_windows_amd64.zip)

**Step 4** - Unzip the downloaded file and place the unzipped (**akash.exe**) into a directory in your `Documents` folder. We suggest you use the following location -  `\Documents\Akash` as the location. However, you can use whatever location you want, just be certain to reference your installation directory accordingly. 

All of our examples will refer to this "*Installation Folder*" as this location - `\Documents\Akash`

**Step 5** - Open a Command Window in your installation folder as defined in below;

![](https://i.imgur.com/rMi4bNh.png)

1. Go to your desired folder and click on the location bar of Windows Explorer.
2. Then type **`cmd`** and press Enter key.
3. The command prompt will be opened in the folder.

![](https://i.imgur.com/KUjClDK.png)

**Test your installation** - In the command Prompt window enter the following command. This should produce results showing the current version of **Akash** that you have installed.

    akash.exe version
 

![](https://i.imgur.com/uCW66EV.png)

If your results are similar then you have successfully installed Akash.

### Akash Wallet Configuration ###

Now that you have Akash installed and operational. The following steps will walk you thru the process of importing your existing wallet that was used for Staking Akash with a Validator. 

You can use wallets created using Keplr or wallets created using Cosmostation Mobile App. However, only wallets created with a 24 word mnemonic are compatible. 

**Step 6** - Import your wallet using your 24 word mnemonic. The command to use is, shown below (replace **[wallet_name]** with a name you want for your wallet);

    akash keys add [wallet_name] --recover --keyring-dir .\keys --keyring-backend test

You will be prompted for your 24 word mnemonic. Once entered, your wallet will be added to the local machine's keystore and your wallet address information will be displayed as shown below;

![](https://i.imgur.com/AIkwUMM.png)

*Your results will not match the results shown* - The **name** you chose for your wallet will be displayed along with your wallet's specific **address** and **pubkey**.

### Batch File (akash_reinvest.bat) Configuration ###

The batch file needs to be downloaded and configured before you can execute it with your installation. Follow these steps to complete the setup;

**Step 7** - download the **akash_reinvest.bat** file from github here - [https://github.com/ourlink/akash_reinvest_win64/blob/master/akash_reinvest.bat](https://github.com/ourlink/akash_reinvest_win64/blob/master/akash_reinvest.bat) and save the downloaded file to the same location on you machine as the **akash.exe** .

**Step 8** - Using your favorite text editor (notepad, notepad++, etc...) edit the `akash_reinvest.bat` file

![](https://i.imgur.com/uBihsYQ.png)

In this step we are going to update the following options so that they contain your desired settings;

**AKASH_VALIDATOR** - this is the address of your validator for staking purposes. The address starts with `akashvaloper...`

- akash_validator=[paste in the validator address you want to re-stake your Akash to]

**KEY_ADDRESS** - this is the ADDRESS for your wallet. This is the address that was displayed to you in Step 6 above after importing your wallet.

- key_address=[paste in your wallet address]

**KEY_NAME** - This is the NAME that you called your wallet during the import in Step 6 above.

- key_name=[name of your key without quotes]

**RESERVE_AMT** - This is the amount of Akash (AKT) to leave in your wallet and not use for reinvesting. The amount is listed in atomic units (in our example, we have 5 AKT kept in reserve). We recommend to not set this amount too low! You must keep some Akash for payment of transaction fees.

- reserve_amt=5000000   (atomic representation of AKT)

**THRESHOLD_AMT** - This is the lowest amount of Akash (AKT) that will ever be Re-Staked. In other words, you can adjust this amount to save on transaction fees and set a minimum amount of Akash for re-staking. The amount is listed in atomic units (in our example, we have 2 AKT as the minimum).

- threshold_amt=2000000 (atomic representation of AKT)

## --DISCLAIMER -- ##
***WARNING** - This is a batch script which requires access to your Akash Wallet. Your Akash Wallet will reside on the local machine using the *`--keyring-backend test`* *setting. This setting opens up your wallet to anyone with access to your local machine. By using this batch script you acknowledge that you take full responsibility for the security of your Akash Wallet and this scripts execution.** 

## License ##
Released under the GNU General Public License v3

[http://www.gnu.org/licenses/gpl-3.0.html](http://www.gnu.org/licenses/gpl-3.0.html)
