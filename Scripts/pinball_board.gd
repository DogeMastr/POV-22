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


func _on_pinball_ball_sunk(sinkhole: Node) -> void:
	# ball has just been sunk
	# if sinkhole 2 is sunk then start a random microgame?
	# if all sinkholes are sunk then release all balls, then re-enable the sinkhole colliders
	pass # Replace with function body.
