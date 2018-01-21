# mattermost-bot

    stack build
    LOGIN_ID=v.jousse PASSWORD=secret URL=https://mattermost.url/api/v4/users/login stack exec mattermost-bot-exe

To automatically watch for file changes and recompile:

    stack build --file-watch

To check for unused imports, incomplete pattern matching, and so one, use `pedantic`:

    stack build --pedantic
