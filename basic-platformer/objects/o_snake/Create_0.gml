enum snake
{
	move_right,
	move_left
}

globalvar can_shoot;

state = choose(snake.move_right, snake.move_left)