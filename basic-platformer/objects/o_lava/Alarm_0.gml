/// @description Create little lava particles
with (instance_create_layer(x + random(sprite_width), y - sprite_height / 2, "Lava", o_particle))
{
	//Make the particle image color match your lava
	image_blend = c_purple;
	
}

alarm[0] = random_range(10, 20);