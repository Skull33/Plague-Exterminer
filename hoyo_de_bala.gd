extends Node3D

@onready var agujero_bala_concreto = $concreto

var tipos = [
	"1",
	"2"
]
var puede_borrase = false
var hoyo_bala

func _ready():
	randomize()

func mostrar_hoyo(tipo):
	match  tipo:
		"agujero_bala_concreto":
			rotacion_textura(agujero_bala_concreto)
		_:
			pass

func rotacion_textura(textura):
	textura.visible = true
	textura.animation = tipos[randi() % tipos.size()]
	textura.rotation_degrees.z = randf_range(0, 360)
	if randi() % 2:
		textura.flip_h = true
	await(get_tree().create_timer(3))
	puede_borrase = true
	hoyo_bala = textura

func _process(delta):
	if puede_borrase:
		hoyo_bala.modulate.a = lerp(hoyo_bala.modulate.a, 0, 2 * delta)
		if hoyo_bala.modulate.a == 0:
			queue_free()
