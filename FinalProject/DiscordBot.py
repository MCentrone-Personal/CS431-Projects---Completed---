#!/opt/discord-bots/bin/python3

# Python script to add new users to the login database on a TAKP server.
# change database connection info as needed to point to where your LOGIN SERVER TABLES are located.
# Author: Dr. Bull 

# dependencies:
# Python3 MySQLdb via pip or package manager
# python virtual env for discord modules
#	sudo mkdir /opt/discord-bots
#	sudo python3 -m venv /opt/discord-bots/
#	sudo /opt/discord-bots/bin/pip3 install discord.py[voice]
#   	sudo /opt/discord-bots/bin/pip3 install mysqlclient 

# imports
import os
import MySQLdb
import subprocess
import time
import sys
import os
import discord
import asyncio
import re

from discord.ext import commands

#### START USER SETTINGS ####

# Bot auth token - DO NOT SHARE!
TOKEN = 'MTIyNzI2NjEzMTI1NDA1NDk3Mg.GpXX6W.huWSkKbqBUq_yP_J5uxxmYbWPv1obngnNE1dB8'

# database connection info
connection = MySQLdb.connect(
    host='127.0.0.1',
    user='eqemu',
    passwd='eqemu',
    db='peqmac'     # may be peqmac_ls on your install or something different
)
#### END USER SETTINGS ####

##### DO NOT EDIT FROM HERE #####

# start bot
print("\n\nStarting Al`Kabor, The TAKP Server Login Account Bot")
print("Press Ctrl+C to exit\n")

# log bot into discord
intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)

@client.event
async def on_ready():
	print('Logged in as')
	print(client.user)
	print('-----------')

@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.content.startswith('#help'):
        dmuser = await client.fetch_user(message.author.id)        
        await dmuser.send('Greetings, my name is Al`Kabor. I have been tasked with helping new users establish login accounts on our classic->pop server.')
        await dmuser.send('For help with setting up a new loginserver account type #loginserver.')
        await dmuser.send('For client setup information type #clientsetup.')

    if message.content.startswith('#clientsetup'):
        dmuser = await client.fetch_user(message.author.id)
        await dmuser.send('See: https://wiki.takp.info/index.php?title=Getting_Started for Operating System specific client setup information. Note: You do not need to setup a takproject forum account to play on this server. That is what I am here for!')
        await dmuser.send('The only change you will need to make is point your client to our loginserver at <XXX.XXX.XXX.XXX>. To do this navigate to the game directory and edit the <eqhost.txt> file. Replace both instances of <loginserver.takproject.net> with <XXX.XXX.XXX.XXX>.')
        await dmuser.send('If you have any issues ask them in the server discord text chat channel <Classic-Server>')

    if message.content.startswith('#loginserver'):
        dmuser = await client.fetch_user(message.author.id)
        await dmuser.send('I can help with that, please reply in the private message window with the following:')
        await dmuser.send('#createaccount UserName:Password')

    if message.content.startswith('#createaccount'):
        dmuser = await client.fetch_user(message.author.id)
        accountInfoMesg = message.content.split(" ")
        accountInfo = accountInfoMesg[1].split(":")
        accountUser = str(accountInfo[0]);
        accountPass = str(accountInfo[1]);
        accountOwner = str(message.author);  # grabbing discord username
        await dmuser.send('Creating account: <' + accountUser + '> with password: <' + accountPass + '> owned by: ' + accountOwner)
        
        print("LOG: Request for account by <" + accountUser + "> with password <" + accountPass + "> owned by " + accountOwner)
        

        # Add new account to database
        cursor = connection.cursor()
        sqlCommand = ("INSERT INTO tblLoginServerAccounts "
                    "(AccountName,AccountPassword,AccountEmail,LastLoginDate,LastIPAddress,creationIP,ForumName) " 
                    "VALUES (%s,sha(%s),%s,%s,%s,%s,%s)")

        sqlData = (accountUser,accountPass,'','0000-00-00 00:00:00','127.0.0.1','127.0.0.1',accountOwner)

        cursor.execute(sqlCommand, sqlData)
        connection.commit()
        connection.close()

# run the bot using the TOKEN
client.run(TOKEN)
