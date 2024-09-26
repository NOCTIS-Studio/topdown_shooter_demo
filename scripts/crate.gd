extends ItemContainer
@onready var lid_sprite: Sprite2D = $LidSprite
@onready var spawn_positions: Node2D = $SpawnPositions



func hit():
	if not opened:
		lid_sprite.hide()
		for i in range(5):
			var pos = spawn_positions.get_child(randi()%spawn_positions.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
