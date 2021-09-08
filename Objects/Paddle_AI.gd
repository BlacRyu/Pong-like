extends KinematicBody2D

export var speed := 50

func _physics_process(delta):
	var balls = get_tree().get_nodes_in_group("Balls")
	if (!balls.empty()):
		balls.sort_custom(self, "is_nearer")
		var target_offset : Vector2 = balls[0].position - self.position
		var velocity : Vector2 = target_offset.project(Vector2(0, 1))
		velocity = velocity.clamped(speed * delta)
		move_and_collide(velocity)
	

func is_nearer(obj_a, obj_b): # return true if obj_a is nearer than obj_b
	if (!obj_a or !obj_a.position or !obj_b or !obj_b.position):
		return false
	return (obj_a.position - self.position).length_squared() < (obj_b.position - self.position).length_squared()
