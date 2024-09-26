extends LevelParent


func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera_2d, "zoom", Vector2(1,1),1)
	#tween.tween_property(player, "modulate:a",0,2).from(0.5)

func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(0.6,0.6),1)
