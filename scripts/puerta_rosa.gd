extends StaticBody3D

@onready var audio = $"../../AudioStreamPlayer3D"
@onready var puerta = $".."
@onready var col_puerta = $CollisionShape3D
@onready var roto_1 = $"../../puerta_rota_2/Cube"
@onready var roto_2 = $"../../puerta_rota_2/Cube_001"
@onready var roto_col_1 = $"../../puerta_rota_2/Cube/StaticBody3D/CollisionShape3D"
@onready var roto_col_2 = $"../../puerta_rota_2/Cube_001/StaticBody3D/CollisionShape3D"
@onready var puerta_sonido = $"../../AudioStreamPlayer3D2"
@export var mensaje = "Abrir [E]"

var abrio = false

func _ready():
	roto_1.visible = false
	roto_2.visible = false
	roto_col_1.disabled = true
	roto_col_2.disabled = true

func hacer_texto():
	
	if not abrio:
		abrio = true
		mensaje = "[color=black]ESTO SE ABRE POR OTRO LADO[/color]"
		audio.play()
		await(get_tree().create_timer(2).timeout)
		abrio = false
		mensaje = "Abrir [E]"
	return mensaje

func destuir():
	abrio = true
	mensaje = ""
	puerta_sonido.play()
	puerta.visible = false
	col_puerta.queue_free()
	roto_1.visible = true
	roto_2.visible = true
	roto_col_1.disabled = false
	roto_col_2.disabled = false
	return mensaje
