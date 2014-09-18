Single User Bowling Application
=======

RoR for single user Bowling Application. User interface for this applcation is quite simple. User input valid pins_down value and Frames value got updated accordingly. There is also "Start New Game" button which can be clicked to start the new game session or user want to leave the current game session and give it a fresh start again. This application is also deployed on Heroku so can be check over this link [Bowling Application](http://heeren-bowling.herokuapp.com/throws). 

This application is very basic in functionality and doesn't take any other requirements into consideration. For instance, it should be used by only one user at a time. This is so because there is no User Table and respective associations with this. But this can be easily imbibe in the current code by generating the *User* table and attaching a foriegn Key as User ID in *Throw* database table. 

##Developer's Section##

###Database Table###

One database table called **"Throw"** is implemented. It is formed of two column fields: **position** and **pins_down**. Basically, in this table, information of every throw and how many pins get down is populating for the specific. With every valid input number of pins down, a new row is added into this table and value of position is incremented by 1 with every throw of ball. 

###Models###
There are primarily two model file: throw.rb and game.rb.

**throw.rb** file is putting value bound constraint over entered number of pins down. This is a very basic contraint that value should be non-negative and less than or equal to 10.

**game.rb** It is the core model file. It is providing three main methods. 

First method **can_throw?** is one which signals the end of the game. 

Secondly, **calculate_frames** is taking all data records from **Throw** table and giving the real time score of frames as returning output. 

Third function is termed as **input_score**. It takes input variables **params** from view and create new data record object (but not saved yet). Apart from this, it also checks an important constraint over input value. Suppose in first throw someone knocked down 4 pins and then input value of next throw is entered as 7 (any number greater than 6), then it is not a valid input vaue. This is because number of pins left after first throw is 6 and entering number greater than this is invalid input data. In this case **accept_flag** will be set as *false* otherwise *true*. The only exception to above mentioned constraint are when previous trial(s) were either "Strike" or "Spare".


###Controller###

Controller is basically comprises of three actions: **index**, **create**, **destroy**. They are performing functionality for index view, post request from view to enter the new pins_down value and destroy the enteries in current table to start new game session respectively. 



###View###
User Interface is quite simple. There is single  for submitting the number of pins down and an important **Notices section**. Below this is simple button to restart the game session (new session) and real-time score for each frame is shown underneath this. When the game will be finished then input form will get hidden and Total Final Score of individual will be reflected. 
