extends CharacterBody3D

@onready var collision = $CollisionShape3D
@onready var cam = $Camera3D
@onready var left_wheel = $Wheel_SFX/AudioStreamPlayer3D

@onready var skid_sfx = preload("res://Assets/sounds/skid.wav")

@export var speed = 7.5
@export var deceleration = 3.5

var size_of_street = 5.88

var left_wheel_playing = false
var right_wheel_playing = false

func _ready() -> void:
	print(size_of_street/2 - collision.shape.size.x)

func _process(delta: float) -> void:
	var hori_input = Input.get_axis("move_left","move_right")
	if hori_input != 0:
		velocity.x += speed * hori_input * delta
		
	if velocity.x > 0 and hori_input == -1:
		left_wheel.play()
		
	velocity.x = clampf(velocity.x, -7.0, 7)
	velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	position.x = clampf(position.x, -(size_of_street/2 - collision.shape.size.x), size_of_street/2 - collision.shape.size.x)
	
	if (position.x <= -(size_of_street/2 - collision.shape.size.x) and velocity.x <= 0) or (position.x >= size_of_street/2 - collision.shape.size.x and velocity.x >= 0):
		velocity.x = -velocity.x *.5
	
	cam.transform.basis = Basis()
	cam.rotate_object_local(Vector3.FORWARD, clampf(velocity.x/50, deg_to_rad(-10), deg_to_rad(10)))
	
	move_and_slide()
