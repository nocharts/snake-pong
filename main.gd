extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Snake.scored.connect(_on_scored)

func _on_scored(side: String) -> void:
	$Snake.reset()
	$Scoreboard.on_scored(side)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
