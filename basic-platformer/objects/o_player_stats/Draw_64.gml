/// @description Draw GUI based on the room
if (room == r_title)
{
	draw_set_halign(fa_center);
	draw_set_font(f_title);
	draw_text_colour(room_width / 2 + 4, 24 + 6, "Your Platformer", c_black, c_black, c_black, c_black, 1);
	draw_text_colour(room_width / 2, 24, "Your Platformer", c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(f_start);
	draw_text_colour(room_width / 2 + 1, room_height - 48 + 1, "Press space to play", c_black, c_black, c_black, c_black, 0.7);
	draw_text_colour(room_width / 2, room_height - 48, "Press space to play", c_white, c_white, c_white, c_white, 1);
}

if (room != r_title)
{
	//Draw Health
	for (var i = 1; i <= hp; ++i)
	{
		draw_sprite_ext(s_heart, 0, (i * 25) - 10, 15, 1, 1, 0, c_white, 1);
	}
	//Draw score
	draw_set_font(f_score);
	draw_set_halign(fa_right);
	draw_text(480 - 5, 0, "Score: " + string(gems));
	draw_set_halign(fa_left);
}