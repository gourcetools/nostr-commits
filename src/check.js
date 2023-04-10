const fs = require("fs");
const { Octokit } = require("@octokit/rest");
const { searchQuery } = require("../config"); // Import the search query from the config file
const octokit = new Octokit({
    auth: "ghp_GITHUBAPIKEY"
});

async function main() {
    const excludedRepos = ["sesseor/nostr-relays-list", "nostr-relays-list" ]; // list of excluded repos
    // Check the rate limit status
    const rateLimit = await octokit.rateLimit.get();
    const remaining = rateLimit.data.resources.core.remaining;
    const reset = rateLimit.data.resources.core.reset;
  
    // Wait until rate limit resets if necessary
    if (remaining <= 0) {
        const timeUntilReset = (reset * 1000) - Date.now();
        console.log(`Waiting ${timeUntilReset / 1000} seconds until rate limit resets`);
        await new Promise(resolve => setTimeout(resolve, timeUntilReset));
    }
    // now you can proceed with your API call
    const searchResults = await octokit.search.repos({
        q: searchQuery, // Use the search query from the config file
        sort: "updated",
        order: "desc"
    });
    const filteredResults = searchResults.data.items.filter(repo => !excludedRepos.includes(repo.name)); // filter out excluded repos
    const repo = filteredResults[0];
    const repoTitle = repo.name;
    const repoUrl = repo.html_url;
    const commit = await octokit.repos.getCommit({
        owner: repo.owner.login,
        repo: repo.name,
        ref: repo.default_branch
    });
    const commitName = commit.data.commit.message;
    const commitId = commit.data.sha;
    const commitUrl = commit.data.html_url;

    // Output the information to files
    fs.writeFileSync("../data//REPO-TITLE.txt", repoTitle);
    fs.writeFileSync("../data//REPO-URL.txt", repoUrl);
    fs.writeFileSync("../data//COMMIT-NAME.txt", commitName);
    fs.writeFileSync("../data//COMMIT-ID.txt", commitId);
    fs.writeFileSync("../data//COMMIT-URL.txt", commitUrl);
}

main();
