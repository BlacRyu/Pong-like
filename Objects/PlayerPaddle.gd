extends KinematicBody2D

export var paddle_speed := 80

func _physics_process(delta):
	var velocity := 0
	velocity -= paddle_speed * Input.get_action_strength("paddle_up")
	velocity += paddle_speed * Input.get_action_strength("paddle_down")
	move_and_collide(Vector2(0, velocity * delta))
