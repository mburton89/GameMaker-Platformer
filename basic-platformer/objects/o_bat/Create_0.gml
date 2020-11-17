/// @description Initialize the bat

//Movement variables
xspeed = 0;
yspeed = 0;
max_speed = 1.5;

enum bat
{
	idle,
	chase
}

state = bat.idle;
sight = 180;