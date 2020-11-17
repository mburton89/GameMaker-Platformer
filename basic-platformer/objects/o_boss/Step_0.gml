/// @description Execute the state
switch (state)
{
	#region Idle State
	case boss.idle:
		var dis = point_distance(x, y, o_player.x, o_player.y);
		if (dis <= sight)
		{
			state = boss.lift;
		}
	break;
	#endregion
	#region Lift state
	case boss.lift:
		image_index = 1;
		yspeed = -3.5;
		move(o_solid);
		if(place_meeting(x, y - 100, o_solid))
		{
			yspeed = 0;
			state = boss.chase;
		}
	break;
	#endregion
	#region Chase State
	case boss.chase:
		var dis = point_distance(x, y, o_player.x, y);
		//If we're above the player, come smashing down
		if (dis < (sprite_width / 2 - 16) or place_meeting(x - 1, y, o_solid) or place_meeting(x + 1, y, o_solid))
		{
			// WE FOUND THE PLAYER. GET HIM!
		    state = boss.smash;
		    audio_play_sound(a_jump, 6, false);
		    xspeed = 0;
		} 
		else
		{
		    xspeed = (o_player.x - x) * .015;   
		}
		move(o_solid);
	break;
	#endregion
	#region Smash state
	case boss.smash:
		//TODO
		//makes boss smash player
		if(!place_meeting(x, y + 1, o_solid))
		{
			yspeed += .5;
			move(o_solid);
		}
		else
		{
			state = boss.stall;
			alarm[0] = 60;
			audio_play_sound(a_step, 5, false);
			if(place_meeting(x, y, o_lava))
			{
				hp -= 1;
				audio_play_sound(a_snake, 5, false);
			}
		}
	break;
	#endregion
	#region Stall State
	case boss.stall:
		image_index = 0;
		if (alarm[0] == -1)
		{
			state = boss.lift;
		}
	break;
	#endregion
}

//Draw the boss as red when in lava
if (place_meeting(x, y, o_lava))
{
	image_blend = c_red;
}
else
{
	image_blend = c_white;
}

if(hp <= 0)
{
	repeat(50)
	{
		var particle = instance_create_layer(bbox_left + random(sprite_width - 24),
		bbox_top + random(sprite_height),
		"Lava", 
		o_particle);
		particle.image_blend = c_red;
	}
	instance_destroy();
}
