extends Node2D

@export var FlipperLeft  := CharacterBody2D
@export var FlipperRight  := CharacterBody2D

@export var restAngle = 45

var flipStrength = .13
var flipFalloff = .005

var fLeftVel = 0
var fRightVel = 0

func _ready():
	pass
	
	
func _process(_delta: float):
	# LEFT FLIPPER CONTROLS
	if Input.is_action_just_pressed("FlipperLeft") and FlipperLeft.rotation >= restAngle:
		fLeftVel = flipStrength
		print(FlipperLeft.rotation)
	
	FlipperLeft.rotation -= fLeftVel
	fLeftVel -= flipFalloff
	if FlipperLeft.rotation >= restAngle:
		fLeftVel = 0
		FlipperLeft.rotation = restAngle
		
	# RIGHT FLIPPER CONTROLS
	if Input.is_action_just_pressed("FlipperRight") and FlipperRight.rotation <= -restAngle:
		fRightVel = flipStrength
		print(FlipperRight.rotation)
	pass
	
	FlipperRight.rotation += fRightVel
	fRightVel -= flipFalloff
	if FlipperRight.rotation <= -restAngle:
		fRightVel = 0
		FlipperRight.rotation = -restAngle
