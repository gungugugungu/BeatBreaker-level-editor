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
The app accepts any mp3 file. Just put any song with the title "song.mp3" and the app will play it after a restart.
## Saving
The app saves when you press "S", and loads when you press "O"
## Importing to the game
You'll find a "save.json" file in the app's directory. Take it along with the mp3 file or the [PDA converted song.mp3](https://ejb.github.io/wav-pda-converter/) and rename them both to your levels name, and put them both in this folder in the game's files:
> data/levels/

This is quite janky yet, and it might be fixed when I lose motivation on another project and need a break.

# **The code is quite janky, but the app works well already. If there any bugs or questions, feel free to open a Github issue**