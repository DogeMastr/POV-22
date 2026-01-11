extends CharacterBody3D

@onready var collision = $CollisionShape3D
@onready var cam = $Camera3D
@onready var left_wheel = $Wheel_SFX/Left_Wheel
@onready var right_wheel = $Wheel_SFX/Right_Wheel

@onready var skid_sfx = preload("res://Assets/sounds/skid.wav")

@export var speed = 7.5
@export var deceleration = 3.5

var size_of_street = 5.88

var left_wheel_playing = false
var right_wheel_playing = false
var default_wheel_db



func _ready() -> void:
	print(size_of_street/2 - collision.shape.size.x)
	default_wheel_db = left_wheel.volume_db
	EventBus.has_died.connect(die)
func _process(delta: float) -> void:
	var hori_input = Input.get_axis("move_left","move_right")
	if EventBus.is_dead:
		hori_input = 0
		
	if hori_input != 0:
		velocity.x += speed * hori_input * delta
		
	if velocity.x >= 0 and hori_input == -1:
		if not left_wheel_playing:
			left_wheel.volume_db = default_wheel_db
			left_wheel.play()
			left_wheel_playing = true
	elif hori_input != -1 and left_wheel_playing:
		var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(left_wheel, "volume_db", -80.0, .5)
		left_wheel_playing = false
	
	if velocity.x <= 0 and hori_input == 1:
		if not right_wheel_playing:
			right_wheel.volume_db = default_wheel_db
			right_wheel.play()
			right_wheel_playing = true
	elif hori_input != 1 and right_wheel_playing:
		var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(right_wheel, "volume_db", -80.0, .5)
		right_wheel_playing = false
	
	velocity.x = clampf(velocity.x, -7.0, 7)
	velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	position.x = clampf(position.x, -(size_of_street/2 - collision.shape.size.x), size_of_street/2 - collision.shape.size.x)
	
	if (position.x <= -(size_of_street/2 - collision.shape.size.x) and velocity.x <= 0) or (position.x >= size_of_street/2 - collision.shape.size.x and velocity.x >= 0):
		velocity.x = -velocity.x *.5
		AudioManager.play_sfx("Hit_Wall")
	
	cam.transform.basis = Basis()
	cam.rotate_object_local(Vector3.FORWARD, clampf(velocity.x/50, deg_to_rad(-10), deg_to_rad(10)))
	
	move_and_slide()

func _on_left_wheel_finished() -> void:
	left_wheel_playing = false
	
func _on_right_wheel_finished() -> void:
	right_wheel_playing = false
	
func die():

	set_collision_layer_value(2, false)
	
