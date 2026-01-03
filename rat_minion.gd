class_name Malo
extends CharacterBody3D

@onready var jugador = get_parent().get_node("Jugador")
@onready var sonido_ataque = $atacar
@onready var sonido_quieto = $quietud
@onready var sonido_muerto = $muerto
@export var velocidad = 10.0
@onready var agente = $NavigationAgent3D
@onready var animaciones = $CollisionShape3D/Sprite3D/AnimationPlayer
@onready var colision = $CollisionShape3D
@onready var vida = $SubViewport/Panel/Barra_Salud
@onready var sprite_vida = $Sprite3D
@onready var zona_de_ataque = $Area3D
@onready var timer_ataque = $TimerAtaque
@onready var rayos = [
	$rayo_izq12,
	$rayo_izq11,
	$rayo_izq10,
	$rayo_izq9,
	$rayo_izq8,
	$rayo_izq7,
	$rayo_izq6,
	$rayo_izq5,
	$rayo_izq4,
	$rayo_izq3,
	$rayo_izq2,
	$rayo_frente,
	$rayo_atras,
	$rayo_der2,
	$rayo_der3,
	$rayo_der4,
	$rayo_der5,
	$rayo_der6,
	$rayo_der7,
	$rayo_der8,
	$rayo_der9,
	$rayo_der10,
	$rayo_der11,
	$rayo_der12,
	$rayo_frente2, 
	$rayo_atras2, 
	$rayo_izq13, 
	$rayo_izq14, 
	$rayo_izq15, 
	$rayo_izq16, 
	$rayo_izq17, 
	$rayo_izq18, 
	$rayo_izq19, 
	$rayo_izq20, 
	$rayo_izq21, 
	$rayo_izq22, 
	$rayo_izq23, 
	$rayo_der13, 
	$rayo_der14, 
	$rayo_der15, 
	$rayo_der16, 
	$rayo_der17, 
	$rayo_der18, 
	$rayo_der19, 
	$rayo_der20, 
	$rayo_der21, 
	$rayo_der22, 
	$rayo_der23
]
@onready var item_dropeables = [
	"res://municion.tscn",
	"res://variante_botiquin.tscn"
]
signal Soy_malo
signal muerto
var esta_vivo = true
var sigue_vivo = true
var esta_en_zona_de_ataque = false
var salud = 50
var daño = 8
var jugador_en_rango: EsJugador = null
func _ready():
	animaciones.play("idle")
	sonido_quieto.play()
	vida.iniciar_salud(salud)
	zona_de_ataque.body_entered.connect(entro_a_la_zona_de_ataque)
	zona_de_ataque.body_exited.connect(salio_de_la_zona_de_ataque)
	timer_ataque.timeout.connect(hora_de_atacar)

func _physics_process(delta):
	velocity.y -= 9.8 * delta
	
	for rayo in rayos:
		if rayo.is_colliding():
			var deteccion = rayo.get_collider()
			if deteccion is EsJugador and esta_vivo and not esta_en_zona_de_ataque:
				posicion_jugador(jugador)
				animaciones.play("andar")
				var localizacion_actual = global_transform.origin
				var siguiente_localizacion = agente.get_next_path_position()
				var seguimiento = (siguiente_localizacion - localizacion_actual).normalized() * velocidad
				velocity = velocity.move_toward(seguimiento, 0.2)
	
	move_and_slide()

func posicion_jugador(jugador):
	agente.target_position = jugador.global_transform.origin

func entro_a_la_zona_de_ataque(cuerpo):
	if cuerpo is EsJugador and esta_vivo:
		esta_en_zona_de_ataque = true
		jugador_en_rango = cuerpo
		timer_ataque.start()

func salio_de_la_zona_de_ataque(cuerpo):
	if cuerpo is EsJugador and esta_vivo:
		esta_en_zona_de_ataque = false
		jugador_en_rango = null
		timer_ataque.stop()

func recibir_daño(bala):
	if not esta_vivo:
		return
	emit_signal("Soy_malo")
	print("Auch... me duele")
	var nueva_salud = salud - bala.daño
	salud = nueva_salud
	if is_instance_valid(vida):
		vida.set_salud(salud)
	if nueva_salud <= 0:
		emit_signal("muerto")
		animaciones.play("morir")
		sonido_muerto.play()
		esta_vivo = false
		collision_layer = 0
		collision_mask = 0
		set_physics_process(false)
		velocity = Vector3.ZERO
		sprite_vida.queue_free()
		var ruta = item_dropeables.pick_random()
		var escena = load(ruta)
		var item = escena.instantiate()
		get_parent().add_child(item)
		item.global_transform.origin = global_transform.origin
func hora_de_atacar():
	if esta_vivo and jugador_en_rango != null:
		jugador_en_rango.hemos_sido_dañados(self)
		animaciones.play("atacar")
		sonido_ataque.play()
