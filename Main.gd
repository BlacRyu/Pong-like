extends Node

var ball_resource = preload("res://Objects/Ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_LevelBounds_body_exited(body : PhysicsBody2D):
	if (body.is_in_group("Balls")):
		body.queue_free()
		var new_ball = ball_resource.instance()
		new_ball.add_to_group("Balls")
		self.add_child(new_ball, true)
