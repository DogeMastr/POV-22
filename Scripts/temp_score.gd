extends Label

var score_to_display = 1

func _process(delta: float) -> void:
	text = str(score_to_display)
