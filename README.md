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
Once you press the S button, the app will copy a lua table to your clipboard.
## Importing to the game
Create a *song_name*.lua *(of course do not call it song_name)* file in this pattern:
```
-- replace song name with what you want your song to be called
-- paste the table put onto your clipboard by the app
song_name = {}
return song_name
```
 [Then convert the song.wav file to a PDA](https://ejb.github.io/wav-pda-converter/), rename it to the exact name you called the lua file and the table in it, and then put the 2 files and put in the game's files here:

> data/levels/

This is quite janky yet, and it might be fixed when I lose motivation on another project and need a break.

# **The code is quite janky, but the app works well already. If there any bugs or questions, feel free to open a Github issue**