extends Control

@onready var audio = $AudioStreamPlayer

func _ready():
	audio.play()
	await(get_tree().create_timer(5).timeout)
	get_tree().change_scene_to_file("res://escena_menu.tscn")
