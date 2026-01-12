extends Node2D

@export var FlipperLeft  := CharacterBody2D
@export var FlipperRight  := CharacterBody2D

@export var restAngle = 21

var flipStrength = .13
var flipFalloff = .005

var fLeftVel = 0
var fRightVel = 0


func _ready() -> void:
	restAngle = deg_to_rad(restAngle)
	EventBus.is_dead = false

	
func _process(_delta: float):
	# LEFT FLIPPER CONTROLS
	if Input.is_action_just_pressed("FlipperLeft") and FlipperLeft.rotation >= restAngle and not EventBus.is_dead:
		fLeftVel = flipStrength
	
	FlipperLeft.rotation -= fLeftVel
	fLeftVel -= flipFalloff
	if FlipperLeft.rotation >= restAngle:
		fLeftVel = 0
		FlipperLeft.rotation = restAngle
		
	# RIGHT FLIPPER CONTROLS
	if Input.is_action_just_pressed("FlipperRight") and FlipperRight.rotation <= -restAngle and not EventBus.is_dead:
		fRightVel = flipStrength
	
	FlipperRight.rotation += fRightVel
	fRightVel -= flipFalloff
	if FlipperRight.rotation <= -restAngle:
		fRightVel = 0
		FlipperRight.rotation = -restAngle

var sunk_sinkholes = []
@export var release_force := Vector2(-1000.0, -1000.0)
func _on_pinball_ball_sunk(sinkhole: Node) -> void:
	print(sinkhole.name)
	# ball has just been sunk, start an interuption
	interupt()
	
	# if all sinkholes are sunk then release all balls, then re-enable the sinkhole colliders
	sunk_sinkholes.push_front(sinkhole);
	if $Sinkholes.get_children().size() == sunk_sinkholes.size(): # if 2 == 2
		# all sunk
		sunk_sinkholes = []
		for ball in $PinballSpawner.get_pinballs():
			ball.freeze = false
			ball.apply_force(release_force)
	else:
		# spawn pinball
		$PinballSpawner.spawn_uninit()
	pass # Replace with function body.

func interupt():
	var random = randi_range(1,15) # idk how many phone calls or ads we have but its one of them?
	pass
