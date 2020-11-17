/// @description Initialize The Boss

xspeed = 0;
yspeed = 0;
hp = 3;
sight = 128;

enum boss
{
	idle,
	lift,
	chase,
	smash,
	stall
}
state = boss.idle;