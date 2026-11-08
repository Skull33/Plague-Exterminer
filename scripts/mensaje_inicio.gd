extends Control

@onready var animacion = $AnimationPlayer
@onready var audio = $AudioStreamPlayer2D

func _ready():
	await(get_tree().create_timer(3).timeout)
	animacion.play("aparece")
	audio.play()
	await(audio.finished)
	animacion.play("desaparece")
	await(animacion.animation_finished)
	get_tree().change_scene_to_file("res://cuarto_prota.tscn")
