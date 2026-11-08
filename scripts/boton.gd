extends StaticBody3D

signal interactuado_1
@export var mensaje = "Presionar [E]"
@onready var mesh_node: MeshInstance3D = $".."
@onready var sonido = $"../../AudioStreamPlayer3D"

var abrio = false

@onready var boton_rojo = preload("res://texturas/boton_rojo.png")
@onready var boton_verde = preload("res://texturas/boton_verde.png")

func _ready() :
	var nuevo_material = StandardMaterial3D.new()
	nuevo_material.albedo_texture = boton_rojo
	nuevo_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mesh_node.set_surface_override_material(1,nuevo_material)

func hacer_texto():
	if abrio:
		return ""
	abrio = true
	emit_signal("interactuado_1")
	var nuevo_material = StandardMaterial3D.new()
	sonido.play()
	nuevo_material.albedo_texture = boton_verde
	nuevo_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mesh_node.set_surface_override_material(1,nuevo_material)
	mensaje = ""
	return mensaje
