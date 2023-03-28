# nostr-commits
Simple shell bot that broadcast nostr events when you update a github repo.

## Requirements:
- `nostril` and `websocat` 
- Node.js with: `Octokit` and `fs` modules.
- a Github API token

## Getting Started <br>
To get started with Nostr-Commits: clone the repo.
```
git clone https://github.com/gourcetools/nostr-commits
cd nostr-commits
```
Install Ocotkit and fs:
```
npm i fs
npm i OCtokit
```
Open both files to edit them (example command for Sublime Text): <br>
```
subl ./check_commits.sh
subl ./check_commits.js
```
**In the shell script:** edit the variables (PRIVKEY, RELAYS, POW, DELAY)
**In the Python script**, read comments as they will guide you through the setup process. 

![image](https://user-images.githubusercontent.com/120996278/228252469-dcba5ee8-6052-4b51-a1ef-224c58a8220e.png)

<br>Once you have completed these steps, save the files and run check-commits.sh to start the bot.
```
./check-commits.sh
```

The bot should be running, you can look at the console for informations about wha't going on.

![image](https://user-images.githubusercontent.com/120996278/228253457-bf2c9d17-8b9c-4bc2-ae04-506e9c677042.png)




## 🙋‍♂️ Need help? <br> 
### <b>Telegram:</b> https://t.me/bitpaint <br>
### <b>Twitter:</b> https://twitter.com/bitpaintclub <br>
### <b>Nostr:</b> <br>
#### hex: 
``` 
0000005cc4586681ad8e7f4b75436fb7904b0e34ff072bb3406ddb90226d7eab 
``` 
#### npub: 
``` 
npub1qqqqqhxytpngrtvw0a9h2sm0k7gykr35lurjhv6qdhdeqgnd064swghgx4 
``` 
#### nip05: 
``` 
gourcetools@gourcetools.github.io 
```
