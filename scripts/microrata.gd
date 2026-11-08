extends CharacterBody3D

@onready var jugador = get_tree().get_first_node_in_group("jugador")
@onready var animaciones = $Sprite3D/AnimationPlayer
@onready var anims_sombra = $Sprite3D2/AnimationPlayer
@onready var colision = $CollisionShape3D
@onready var area_explosion = $Area3D/CollisionShape3D

var velocidad = 20

func _ready() -> void:
	animaciones.play("walk")
	anims_sombra.play("walk")
