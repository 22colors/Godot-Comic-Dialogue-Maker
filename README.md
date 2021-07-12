# Godot-Comic-Dialogue-Maker
How to play a comic dialogue in your Godot project: 1. Use a text file as your dialogue script, 2. add your own graphics.

In order to tell some stories, I needed a simple way to create comics within my Godot game. 

Godot looks for a textfile with such content:

["background-image", "character1-image", "character2-image", "12", "text1", "text2"],

The smaller speech bubbles are scaled automatically according to the amount of text. 
The big bubble (for a longer text) stays in the same size.

See a working example here: http://www.22colors.de/en/comic-dialogue-maker-for-godot/


How to use it
------------------

You can exchange or add any graphics in the IMAGES folder:

- characters (use PNG files only!)
- backgrounds (use JPG files only!)
- button in three stages
- arrow for the button
- progress bar
- bubbles (PNG)


Speech Bubbles
--------------

The standard bubble is bubble-0.png. It is made for character 1 (left side), and the script automatically flips it for character 2 (right side).	

If you want one of the characters to speak a lot of words, the "big" bubble is called bubble-b.png. In the text file that controls the comic, write "%b" before you begin your text. Example: "%bThis is my long text"

In this way, you could also create many more bubbles: Just call them bubble-1.png or bubble-x.png (use one character after the hyphen). In your text file you can then tell the script to use them in the same way: "%1This is bubble 1" or "%xThis is bubble x".


And those numbers...?
----------------------------
In the text file, there is one section with a two digit number. This is what it does:

* 12 = character 1 speaks first, then character 2
* 21 = character 2 speaks first, then character 1
* 10 = only character 1 speaks 
* 20 = only character 2 speaks 
* 00 = no one speaks


Notes
------------
- "Speed" value in the text file: You can change this value. It is used as a pause in between the appearance of the speech bubbles, text and buttons to continue or go back.

- Resolution: The project is set up for 320 x 180. Please beware, if you decide to change this, or if you change the font (or size), all scaling and position values need to be changed in the script.

- Errors: If you get an error, it is very likely that you misplaced or missed a quotation or comma in the text file. The script doesn´t check for correct writing, so be careful when you create your text.

- License: You can use the script and the graphics in any way you want, also commercially, without attribution. 
Of course, I would be happy to see if the script was useful for you and I am curious in what projects you are implementing it. 

