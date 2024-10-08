extends Area2D


@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
@onready var self_distruct: Timer = $SelfDistruct

func _ready() -> void:
	self_distruct.start()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	


func _on_body_entered(body: Node2D) -> void:
	#if "hit" in  body:
	if body.has_method("hit"):
		body.hit()
	queue_free()


func _on_self_distruct_timeout() -> void:
	queue_free()
