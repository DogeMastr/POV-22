extends Control

@export var driving_song = preload("res://Assets/Music/drive.wav")

func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	AudioManager.crossfade_music_to(driving_song)
	EventBus.is_dead = false
	EventBus.game_start.emit()
	
