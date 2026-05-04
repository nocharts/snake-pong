extends CharacterBody2D

signal scored(side)

var direction = Vector2(1, 6).normalized()  # starting diagonal direction
var speed = 300.0

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.GREEN)

func _physics_process(delta: float) -> void:
	velocity = direction*speed
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		velocity = velocity.bounce(collision.get_normal())
		direction = direction.bounce(collision.get_normal())
		speed += 100
	
	# Out of bounds detection
	if position.x < 0:
		emit_signal("scored", "left")
	elif position.x > get_viewport().get_visible_rect().size.x:
		emit_signal("scored", "right")

	move_and_slide()

func reset() -> void:
	var angle = randf_range(PI/3, 5*PI/12)  # 60-75 degrees from horizontal
	# 50% chance flip vertical
	if randf() > 0.5:
		angle *= -1
	# 50% chance go left
	direction = Vector2(cos(angle), sin(angle))
	if randf() > 0.5:
		direction.x *= -1

	speed = 300
	position.x = get_viewport().get_visible_rect().size.x / 2
	position.y = get_viewport().get_visible_rect().size.y / 2
