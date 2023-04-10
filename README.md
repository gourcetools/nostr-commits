# nostr-commits
Simple shell bot that broadcast nostr events when you update a github repo.

## Requirements:
- `nostril` `websocat`  `node`
- Github API key
- A HEX private key to publish with

## Getting Started <br>
To get started with Nostr-Commits: clone the repo.
```
git clone https://github.com/gourcetools/nostr-commits
cd nostr-commits/src
```
Install Ocotkit and fs:
```
npm i fs octokit
```
Open both files to edit them (this example command use Sublime Text): <br>
```
subl ./src/check.sh
subl ./src/check.js
```
### For check.**sh:** edit the variables (PRIVKEY, RELAYS, POW, DELAY) 
### For check.**js**, line 5: set a github api key. 
### Edit config.js with what you want to search for, you can see examples of configurations in config_examples.txt.

```
subl ./config.js
subl ./config_examples.txt
```

<br>Once you have completed these steps, save the changes to theses 3 files and run check.sh to start the bot.
```
./check.sh
```

The bot should be running in loop, you can look at the console for informations about what is going on.

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
