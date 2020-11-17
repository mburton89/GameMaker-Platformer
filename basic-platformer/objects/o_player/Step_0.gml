/// @description Controlling the players state

#region Set up controls for the player
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
up_release = keyboard_check_released(ord("W"));
shoot = keyboard_check_pressed(vk_shift);
#endregion

// State Machine
switch (state)
{
#region Move State
	case player.moving:
	if (xspeed == 0)
	{
		sprite_index = s_player_idle;
	}
	else
	{
		sprite_index = s_player_walk;
	}
	//Check if player is on the ground
	if (!place_meeting(x, y + 1, o_solid))
	{
		yspeed += gravity_acceleration;
		
		//Player is in the air
		sprite_index = s_player_jump;
		image_index = (yspeed > 0);
		
		//Control the jump height
		if (up_release and yspeed < -6)
		{
			yspeed = -3;
		}
	}
	else
	{
		yspeed = 0;
		
		//Jumping code
		if (up)
		{
			yspeed = jump_height;
			audio_play_sound(a_jump, 5, false);
		}
	}
	//Change direction of sprite
	if (xspeed != 0)
	{
		image_xscale = sign(xspeed);
	}
	//Check for moving left or right
	if (right or left)
	{
		xspeed += (right - left) * acceleration;
		xspeed = clamp(xspeed, -max_speed, max_speed);
	}
	else
	{
		apply_friction(acceleration);
	}
	
	if (place_meeting(x, y + yspeed + 1, o_solid) and yspeed > 0)
	{
		audio_play_sound(a_step, 6, false);
	}
	
	move(o_solid);
	
	//Check for ledge grab state
	var falling = y - yprevious > 0;
	var wasnt_wall = !position_meeting(x + grab_width * image_xscale, yprevious, o_solid);
	var is_wall = position_meeting(x + grab_width * image_xscale, y, o_solid);
	
	if (falling and wasnt_wall and is_wall)
	{
		xspeed = 0;
		yspeed = 0;
		
		//Move against the ledge
		while (!place_meeting(x + image_xscale, y, o_solid))
		{
			x += image_xscale;
		}
		
		//Check vertical position
		while (position_meeting(x + grab_width * image_xscale, y - 1, o_solid))
		{
			y -= 1;
		}
		
		//Change sprite and state
		sprite_index = s_player_ledge_grab;
		state = player.ledge_grab;
		
		audio_play_sound(a_step, 6, false);
	}
	
	break;
#endregion
#region Ledge Grab state
	case player.ledge_grab:
		if (down)
		{
			state = player.moving;
		}
		if (up)
		{
			state = player.moving;
			yspeed = jump_height;
		}
	break;
#endregion
#region Door state
	case player.door:
	sprite_index = s_player_exit;
	if(image_alpha > 0)
	{
		image_alpha -= 0.05;
	}
		else
	{
		room_goto_next();
	}
	break;
#endregion
#region Hurt state
	case player.hurt:
		sprite_index = s_player_hurt;
		//Change direction as we fly around
		if (xspeed != 0)
		{
			image_xscale = sign(xspeed);
		}
		if (!place_meeting(x, y + 1, o_solid))
		{
			yspeed += gravity_acceleration;
		}
		else
		{
			yspeed = 0;
			apply_friction(acceleration);
		}
		direction_move_bounce(o_solid);
		
		//Change back to the other states
		if (xspeed == 0 and yspeed == 0)
		{
			image_blend = c_white;
			state = player.moving;
		}
		
		if (o_player_stats.hp == 0)
		{
			alarm[0] = 60;
		}
		
	break;
#endregion
#region Death state
	case player.death:
		with(o_player_stats)
		{
			hp = max_hp;
			gems = 0;
		}
		room_restart();
	break;
#endregion
}

if (shoot)
{
	projectile = instance_create_layer(x, y, "Player", o_player_projectile);
	projectile.xspeed = 5 * image_xscale;
	audio_play_sound(a_laser, 5, false);
}


