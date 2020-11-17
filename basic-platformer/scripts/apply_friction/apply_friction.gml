/// @description apply_friction(amount)
/// @param amount
function apply_friction(argument0) {
	var amount = argument0;

	//Check to see if we're moving
	if (xspeed != 0)
	{
		if (abs(xspeed) - amount > 0)
		{
			xspeed -= amount * image_xscale;
		}
		else
		{
			xspeed = 0;
		}
	}


}
