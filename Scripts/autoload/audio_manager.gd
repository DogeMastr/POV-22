extends Node

const mute_db := -80.0 # To mute the audio player
const default_music_db := -15.0 # This is for normal volume
const fade_time := 2.0 # The time it takes to fade in/out in seconds

var current_music_player: AudioStreamPlayer # the current player
var current_track: AudioStream

@onready var audio_stream_01: AudioStreamPlayer = $AudioStreamPlayer1
@onready var audio_stream_02: AudioStreamPlayer = $AudioStreamPlayer2



func _ready() -> void:
	current_music_player = audio_stream_01

	audio_stream_01.finished.connect(track_finished)
	audio_stream_02.finished.connect(track_finished)

func restart_music():
	crossfade_music_to(current_track)


func fade_music_in(track: AudioStream) -> void:
	current_music_player.stream = track # Specify the song
	current_music_player.volume_db = mute_db # Mute the player
	current_music_player.play() # Start playing
	# Use tweens for transition:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", default_music_db, fade_time)


func fade_music_out() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(current_music_player, "volume_db", mute_db, fade_time)


func crossfade_music_to(track: AudioStream) -> void:
	fade_music_out() # Fade out first player

	current_track = track

	# Switch current Player:
	current_music_player = audio_stream_01 if current_music_player == audio_stream_02 else audio_stream_02
	fade_music_in(track) # Fade in second player

func track_finished():
	Eventbus.track_ended.emit()

func play_sfx(name: String):
	$Sounds.get_node(name).play()
