/// @description Jump
if (state == spider.idle)
{
	if (instance_exists(o_player))
	{
		xspeed = sign(o_player.x - x) * max_speed;
		yspeed = -abs(xspeed * 2);
	}
	
	move(o_solid);
	state = spider.jump;
}