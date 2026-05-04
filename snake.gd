extends CharacterBody2D

signal scored(side)

var direction = Vector2(1, 1.5).normalized()  # starting diagonal direction
var was_colliding = false
var speed = 500.0

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.GREEN)

func _physics_process(delta: float) -> void:
	velocity = direction*speed
	
	var collision_count = get_slide_collision_count()
	
	for i in collision_count:
		var collision = get_slide_collision(i)
		
		print("Collided with: ", collision.get_collider().name)
		if collision.get_collider() is Paddle:	
			var paddle = collision.get_collider()	
			var paddle_center = paddle.position
			var paddle_length = paddle.get_node("CollisionShape2D").shape.size.y
			var hit_position = collision.get_position()
			var offset = hit_position.y - paddle_center.y
			var fraction = offset / (paddle_length/2)  # gives -1 to 1
			var flip_dir = sign(collision.get_normal().x)
			var angle = flip_dir * sign(fraction)*fraction**2 * (0.7*PI / 2)
			var bounce_direction = collision.get_normal().rotated(angle)
			
			direction = bounce_direction.normalized()
			speed += 10.0
			
		if collision.get_collider() is Edge:	
			if not was_colliding:
				print("bouncing")
				velocity = velocity.bounce(collision.get_normal())
				direction = direction.bounce(collision.get_normal())
				break
	if collision_count > 0:
		was_colliding = true
	else:
		was_colliding = false

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

	speed = 500
	position.x = get_viewport().get_visible_rect().size.x / 2
	position.y = get_viewport().get_visible_rect().size.y / 2	
