extends Area3D

@export var speed = -5

func _process(delta: float) -> void:
	position.z -= speed * delta

	if position.z >= -0.2:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	AudioManager.play_sfx("Crash")
	EventBus.is_dead.emit()
