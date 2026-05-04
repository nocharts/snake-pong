extends HBoxContainer

var p1Score = 0
var p2Score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$P1Score.text = str(p1Score)
	$P2Score.text = str(p2Score)

func on_scored(side: String) -> void:
	if side == "left":
		p2Score += 1
	elif side == "right":
		p1Score += 1
	$P1Score.text = str(p1Score)
	$P2Score.text = str(p2Score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
