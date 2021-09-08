extends KinematicBody2D

class_name Ball

func _init():
	self.position = Vector2(80, 45)

signal ball_bounce(collision)
export var max_bounces_per_frame := 10 # Prevent infinite loops if we get stuck somewhere
export var speed_increase_on_bounce := 1.08 # Increase speed when bouncing off a paddle

var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# Apply a horizontal velocity of 64 randomly to the left or right
	self.velocity.x = 64 * (randi() % 2 * 2 - 1)
	# Apply a random vertical velocity between -32 and 32
	self.velocity.y = randf() * 64 - 32;

func _physics_process(delta):
	var collision : KinematicCollision2D = null
	var remaining_velocity : Vector2 = velocity * delta
	var new_direction : Vector2
	var bounces := 0
	var bounced_off_paddle := false
	
	while (remaining_velocity.length_squared() > 0 && bounces < max_bounces_per_frame):
		collision = self.move_and_collide(remaining_velocity)
		if (collision == null):
			remaining_velocity = Vector2.ZERO
		else:
			bounces += 1
			if (collision.collider.is_class("KinematicBody2D")):
				bounced_off_paddle = true
			var old_direction = remaining_velocity.normalized()
			remaining_velocity = collision.remainder.bounce(collision.normal)
			new_direction = old_direction.bounce(collision.normal)
#			if abs(new_direction.dot(Vector2(1, 0))) < 0.2:
#			new_direction = new_direction.rotated(randf() * 0.5 - 0.25)
			emit_signal("ball_bounce", collision)
	if (bounces > 0):
		velocity = velocity.length() * new_direction
		if (bounced_off_paddle):
			velocity *= speed_increase_on_bounce
			
