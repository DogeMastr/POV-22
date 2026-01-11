extends StaticBody2D

var animation_frame_count = 0
var health = 9;
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
	if health % 3 == 0:
		if $Sprite2D.frame != 3:
			$Sprite2D.frame += 1
		else:
			queue_free()
