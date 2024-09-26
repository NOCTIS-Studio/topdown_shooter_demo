extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_used: bool = true

var health: int = 30
var vulnerable: bool = true
signal laser(pos, direction)

@onready var laser_cooldown: Timer = $Timers/LaserCooldown
@onready var marker_2d: Marker2D = $LaserSpwanPosition/Marker2D
@onready var laser_spwan_position: Node2D = $LaserSpwanPosition
@onready var hit_timer: Timer = $Timers/HitTimer

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		hit_timer.start()
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var marker_node = laser_spwan_position.get_child(right_gun_used)
			right_gun_used = not right_gun_used
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			laser_cooldown.start()
			
func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true


func _on_hit_timer_timeout() -> void:
	vulnerable = true
	
