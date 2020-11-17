/// @description take_damage
function take_damage() {
	if (state != player.hurt)
	{
		state = player.hurt;
	
		audio_play_sound(a_ouch, 8, false);
	
		image_blend = make_colour_rgb(220, 150, 150);
	
		yspeed = -6;
		xspeed = (sign(x - other.x) * 8);
	
		move(o_solid);
	
		if (instance_exists(o_player_stats))
		{
			o_player_stats.hp -= 1;
		}
	}


}
