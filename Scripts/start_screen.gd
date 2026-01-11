extends Control

@export var driving_song = preload("res://Assets/Music/drive.wav")

func _on_button_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	AudioManager.crossfade_music_to(driving_song)
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	EventBus.is_dead = false
	EventBus.game_start.emit()
	
