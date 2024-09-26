extends CharacterBody2D


signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var laser_start_position: Node2D = $LaserStartPosition
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

@export var max_speed: int = 500
var speed: int = max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_position = position
	#rotate
	look_at(get_global_mouse_position())
	#laser shooting
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_ammount > 0:
		Globals.laser_ammount -= 1
		var laser_markers = laser_start_position.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		timer.start()
		gpu_particles_2d.emitting = true
		laser.emit(selected_laser.global_position, player_direction)
	elif Input.is_action_pressed("secondary_action") and can_grenade and Globals.grenade_ammount > 0:
		Globals.grenade_ammount -= 1
		var pos_marker = laser_start_position.get_children()[0].global_position
		can_grenade = false
		timer_2.start()
		grenade.emit(pos_marker, player_direction)


func _on_timer_timeout() -> void:
	can_laser = true


func _on_timer_2_timeout() -> void:
	can_grenade = true
	
func hit():
	Globals.health -= 10
