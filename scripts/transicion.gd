extends CanvasLayer

@onready var animacion = $TextureRect/AnimationPlayer
@onready var sprites = $TextureRect

func _ready():
	layer = -1
	sprites.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	animacion.play("RESET")


func mostrar(ruta: String):
	layer = 1
	animacion.play("animation_transition")
	await(animacion.animation_finished)
	get_tree().change_scene_to_file(ruta)
	animacion.play("animacion salida")
	await(animacion.animation_finished)
	layer = -1
