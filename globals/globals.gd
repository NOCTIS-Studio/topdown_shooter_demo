extends Node

signal stat_change

var player_vulnerable: bool = true
var laser_ammount = 20:
	get:
		return laser_ammount
	set(value):
		laser_ammount = value
		stat_change.emit()
var grenade_ammount = 5:
	get:
		return grenade_ammount
	set(value):
		grenade_ammount = value
		stat_change.emit()
var health = 60:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
		stat_change.emit()
	
var player_position: Vector2

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
