extends Node2D
class_name LevelParent
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")
@onready var items: Node2D = $Items
@onready var player: CharacterBody2D = $Player
@onready var projectiles: Node = $Projectiles
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var ui: CanvasLayer = $UI

func _ready() -> void:
	for i in get_tree().get_nodes_in_group('Container'):
		i.connect("open", _on_container_opened)
	for i in get_tree().get_nodes_in_group('Scout'):
		i.connect("laser", _on_scout_laser)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	items.call_deferred('add_child',item)

func _on_scout_laser(pos, direction):
	create_laser(pos, direction)

func _on_player_laser(pos, direction) -> void:
	create_laser(pos, direction)

func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	projectiles.add_child(laser)
	
func _on_player_grenade(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.SPEED
	projectiles.add_child(grenade)
