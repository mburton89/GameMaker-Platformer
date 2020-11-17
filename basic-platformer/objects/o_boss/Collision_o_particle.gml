/// @description Splash the lava
if (yspeed > 0)
{
	with (other)
	{
		speed = random_range(4, 10);
		direction = random_range(45, 135);
	}
}