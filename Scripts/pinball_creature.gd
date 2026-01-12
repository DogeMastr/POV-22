extends StaticBody2D

var animation_frame_count = 0
var health = 1;
func _process(delta: float) -> void:
	animation_frame_count += 1;
	position.x += cos(animation_frame_count*delta)/30;
	position.y += sin(animation_frame_count*delta)/30;
	
	
	pass
	

var flash_tween: Tween
func gotHit():
	$Sprite2D.modulate = Color(10, 10, 10)
	flash_tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

	flash_tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.3)
	health -= 1
	
	if health == 0:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
	
	if health % 3 == 0:
		if $Sprite2D.frame != 3:
			$Sprite2D.frame += 1
		else:
			print("i should be dead by now")


func _on_animated_sprite_2d_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	$AnimatedSprite2D.stop()
	$RespawnTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = false


func _on_respawn_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.visible = true
	$RespawnTimer.stop()
	
	health = 9
	$Sprite2D.frame = 0
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play_backwards("gif")

func _on_animated_sprite_2d_animation_looped() -> void:
	$AnimatedSprite2D.visible = false
	if health == 0:
		_on_animated_sprite_2d_animation_finished("Looped")
