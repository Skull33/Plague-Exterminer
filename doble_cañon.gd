extends Node3D

@onready var particulas = $GPUParticles3D
@onready var shotgun_audio = $disparar
@onready var jugador = get_tree().get_first_node_in_group("jugador")
var bala = preload("res://bala disparo.tscn")
@onready var spawners = [
	$bulletSpawn, $bulletSpawn2, $bulletSpawn3, $bulletSpawn4, $bulletSpawn5, $GPUParticles3D
]
@export var municion_maxima = 50
@export var municion_minima = 0
@export var municion_actual = 0

func _physics_process(_delta):
	if Input.is_action_just_pressed("disparar"):
		intentar_disparo()
func intentar_disparo():
	if jugador and jugador.puede_disparar and municion_actual > 0:
		disparar()

func disparar():
	particulas.restart()
	shotgun_audio.play()
	for spawn in spawners:
		var instanciar_bala = bala.instantiate()
		instanciar_bala.position = spawn.global_position
		instanciar_bala.transform.basis = spawn.global_transform.basis
		get_tree().get_current_scene().add_child(instanciar_bala)
	municion_actual -=1
	if municion_actual == 0:
		jugador.puede_disparar = false
