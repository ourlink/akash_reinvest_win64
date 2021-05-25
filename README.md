# Akash Reinvest Script (Windows 64) #

----------
## Overview ##
This is a batch file that is designed to work with the **Akash Network** and a local Akash Wallet. 

Using the **Windows Task Scheduler** this batch file can be used to enable the automated withdrawal of Staked Rewards and Reinvestment of these Rewards with an operating Validator on the Akash Network.


***WARNING** - This is a batch script which requires access to your Akash Wallet. Your Akash Wallet will reside on the local machine using the *`--keyring-backend test`* *setting. This setting opens up your wallet to anyone with access to your local machine. By using this batch script you acknowledge that you take full responsibility for the security of your Akash Wallet and this scripts execution.** 

## Configuration Steps ##
To configure your machine for executing this batch script you need to complete each of the steps below;

### Akash Installation ###
This will install the Akash binaries onto your local Windows machine;

**Step 1** - Visit the Akash GitHub site ( [https://github.com/ovrclk/akash/releases/latest](https://github.com/ovrclk/akash/releases/latest) ) and download the latest version of the Akash software for Windows. At the present time the latest version is v0.12.1 and the direct link to the Windows Version is here - [https://github.com/ovrclk/akash/releases/download/v0.12.1/akash_0.12.1_windows_amd64.zip](https://github.com/ovrclk/akash/releases/download/v0.12.1/akash_0.12.1_windows_amd64.zip)

**Step 2** - Unzip the downloaded file and place the unzipped (**akash.exe**) into a directory in your `Documents` folder. We suggest you use the following location -  `\Documents\Akash` as the location. However, you can use whatever location you want, just be certain to reference your installation directory accordingly. 

All of our examples will refer to this "*Installation Folder*" as this location - `\Documents\Akash`

**Step 3** - Open a Command Window in your installation folder as defined in below;

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

**Step 4** - Import your wallet using your 24 word mnemonic. The command to use is, shown below (replace **[wallet_name]** with a name you want for your wallet);

    akash keys add [wallet_name] --recover --keyring-dir .\keys --keyring-backend test

You will be prompted for your 24 word mnemonic. Once entered, your wallet will be added to the local machine's keystore and your wallet address information will be displayed as shown below;

![](https://i.imgur.com/AIkwUMM.png)

*Your results will not match the results shown* - The **name** you chose for your wallet will be displayed along with your wallet's specific **address** and **pubkey**.

### AKASH_REINVEST Configuration ###

The batch file needs to be downloaded and configured before you can execute it with your installation. Follow these steps to complete the setup;

**Step 5** - download the **akash_reinvest.bat** file from github here -