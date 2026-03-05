extends Node3D

@onready var particulas = $GPUParticles3D
@onready var shotgun_audio = $disparar
@onready var jugador = get_tree().get_first_node_in_group("jugador")
var bala = preload("res://bala disparo.tscn")
@onready var spawners = [
	$bulletSpawn, $bulletSpawn2, $bulletSpawn3, $bulletSpawn4, $bulletSpawn5
]
@onready var escopeta = $"."
@onready var anims = $AnimationPlayer

@export var municion_maxima = 50
@export var municion_minima = 0
@export var municion_actual = 0

var recoil = 0.0
var posicion_actual = Vector3.ZERO
@export var tipo_arma: String = "escopeta"

func _ready() :
	self.hide()
	anims.play("RESET")
	posicion_actual = escopeta.position

func _physics_process(_delta):
	if Input.is_action_just_pressed("disparar"):
		intentar_disparo()
	recoil = lerp(recoil,0.0,10.0 * _delta)
	escopeta.position.z = posicion_actual.z - recoil

func intentar_disparo():
	if jugador and jugador.puede_disparar and municion_actual > 0:
		disparar()

func disparar():
	particulas.restart()
	shotgun_audio.play()
	recoil += 0.2
	for spawn in spawners:
		var instanciar_bala = bala.instantiate()
		instanciar_bala.position = spawn.global_position
		instanciar_bala.transform.basis = spawn.global_transform.basis
		get_tree().get_current_scene().add_child(instanciar_bala)
	municion_actual -=1
	jugador.UI_arma()
	jugador.puede_disparar = false
	await get_tree().create_timer(0.2).timeout
	jugador.puede_disparar = true
	anims.play("reload")
	await(anims.animation_finished)
	if municion_actual == 0:
		jugador.puede_disparar = false

func obtener_arma():
	jugador.UI_arma()
	if not jugador.tiene_la_escopeta:
		jugador.tiene_la_escopeta = true
		self.show()
		print("Has obtenido la escopeta")
	else:
		self.show()
