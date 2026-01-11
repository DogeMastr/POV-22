extends Control



@export var dead_song = preload("res://Assets/Music/dead.wav")


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	EventBus.has_died.connect(dying)

func dying() -> void:
	print("lol")
	AudioManager.crossfade_music_to(dead_song)
	mouse_filter = Control.MOUSE_FILTER_STOP
	$VBoxContainer/Button.mouse_filter = Control.MOUSE_FILTER_STOP
	$AnimationPlayer.play("death_fade_in")

func _on_button_pressed() -> void:
	%BlackOut/AnimationPlayer.play("Blackout_fade_in")
	await %BlackOut/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Main_level.tscn")
