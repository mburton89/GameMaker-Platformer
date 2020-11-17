/// @description Move to the next level
if (up and other.visible == true)
{
	y = yprevious;
	state = player.door;
	audio_play_sound(a_exit, 4, false);
	audio_stop_sound(a_jump);
	if (room == r_boss)
	{
		game_restart();
	}
}
