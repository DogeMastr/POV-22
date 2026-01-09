extends RigidBody2D

var bumperStrength = 200

func _on_body_entered(body: Node) -> void:
	#print(body.get_parent().name)
	if body.get_parent().name == "Bumpers":
#		# get angle of collision
		var colVec = body.position - position
		#colVec.angle()
		
		# apply force in that angle
		var bumperForce = -(colVec * bumperStrength)
		apply_force(bumperForce)
		pass
	pass # Replace with function body.
