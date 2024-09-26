extends ItemContainer
@onready var lid_sprite: Sprite2D = $LidSprite
@onready var marker_2d: Marker2D = $SpawnPositions/Marker2D

func hit():
	if not opened:
		lid_sprite.hide()
		var pos = marker_2d.global_position
		open.emit(pos, current_direction)
		opened = true
