extends Node3D

@export var sway_arriba : Vector3
@export var sway_abajo : Vector3
@export var sway_derecha : Vector3
@export var sway_Izquierda : Vector3
@export var sway_normal : Vector3

var movmouseY
var movmousex
@export var sway_limite := 5
@export var sway_lerp := 1

func _input(event):
	if event is InputEventMouseMotion:
		movmouseY = -event.relative.x
		movmousex = event.relative.y

func _physics_process(delta: float) -> void:
	if movmouseY != null:
		if movmouseY > sway_limite:
			rotation = rotation.lerp(sway_Izquierda, sway_lerp * delta)
		elif movmouseY < -sway_limite:
			rotation = rotation.lerp(sway_derecha, sway_lerp * delta)
		
		if movmousex > sway_limite:
			rotation = rotation.lerp(sway_arriba, sway_lerp * delta)
		elif movmousex < -sway_limite:
			rotation = rotation.lerp(sway_abajo, sway_lerp * delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp * delta)
