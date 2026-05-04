extends CharacterBody2D


@export var action_up: String = "ui_up"
@export var action_down: String = "ui_down"
const SPEED = 300.0


func _physics_process(delta: float) -> void:	
	var direction := Input.get_axis(action_up, action_down)
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
