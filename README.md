# What's this?
This is a level editor software created for my *upcoming* game **BeatBreaker** for the Playdate. 

# How to use?
## Bottom panel buttons
### Play button
The play button start the song from the start point you set.
### Stop button
The stop button stops the song. (not pausing)
### Add button
The add button adds a new block, and opens the menu to set it's parameters.
## Side panel
The side panel displays the list of blocks in the song, sorted by the time you made them. If you click on any block it'll start editing it and if you click the delete button you'll delete it. Be aware, there is ***no* undo** button so measure twice, cut once.
## Other stuff
### Songs
The app accepts any wav file. Just put any song with the title "song.wav" and the app will play it after a restart.
## Saving
The app autosaves every time you make a change or just quit the app.
## Importing to the game
Take the song.lua file and the [song.wav converted to a PDA file](https://ejb.github.io/wav-pda-converter/) and put in the game's files here:
> data/levels/

# **The code is quite janky, but the app works well already. If there any bugs or questions, feel free to open a Github issue**