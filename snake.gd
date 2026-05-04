extends CharacterBody2D

var direction = Vector2(1, 6).normalized()  # starting diagonal direction
const SPEED = 300.0

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.GREEN)
	

func _physics_process(delta: float) -> void:
	velocity = direction*SPEED
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		velocity = velocity.bounce(collision.get_normal())
		direction = direction.bounce(collision.get_normal())
	
	move_and_slide()
