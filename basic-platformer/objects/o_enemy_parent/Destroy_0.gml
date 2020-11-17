/// @description Create some blood
repeat (irandom_range(4, 7))
{
	var random_x = irandom_range(-4, 4);
	var random_y = irandom_range(-4, 4);
	var particle = instance_create_layer(x + random_x, y + random_y, "Enemies", o_particle);
	//particle.image_blend = c_red;
	particle.image_speed = .25;
}