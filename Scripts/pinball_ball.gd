extends RigidBody2D

var bumperStrength = 2000
signal ballSunk(sinkhole: Node)

func _on_body_entered(body: Node) -> void:
	#print(body.get_parent().name)
	if body.get_parent().name == "Bumpers":
#		# get angle of collision
		var colVec = (body.position - position).normalized()
		#colVec.angle()
		
		# apply force in that angle
		var bumperForce = -(colVec * bumperStrength)
		apply_force(bumperForce)
	
	if body.get_parent().name == "Sinkholes":
		# keep the ball still
		set_deferred("freeze", true)
		
		# sinkhole can holy hold one ball
		body.get_node("CollisionShape2D").set_deferred("disabled", true)
		
		# send a signal with the sinkhole
		ballSunk.emit(body)
