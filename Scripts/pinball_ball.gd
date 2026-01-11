extends RigidBody2D

var bumperStrength = 2000
signal ballSunk(sinkhole: Node)
signal hitGlorbo()
signal backInChamber(ball: Node)

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
		print("HIIHAHISFIHAHIFGSG")
		# send a signal with the sinkhole
		ballSunk.emit(body)
		
		# sinkhole can holy hold one ball
		body.get_node("CollisionShape2D").set_deferred("disabled", true)
		
		# keep the ball still
		set_deferred("freeze", true)
		
	if body.name == "Glorbo": #hit glorbo
		hitGlorbo.emit()
		
	if body.name == "SpawnLocation": #fell back in the spawn location
		backInChamber.emit(self)
		
