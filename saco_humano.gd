extends CharacterBody3D

@onready var vida = $SubViewport/Panel/Barra_Salud
@onready var anims = $CollisionShape3D/Sprite3D/AnimationPlayer
@onready var sombra = $CollisionShape3D/Sprite3D2/AnimationPlayer
@onready var sprite_vida = $salud
@onready var respiracion = $respiracion
@onready var muerte = $muerte
@onready var rayos = [
	$rayo_frente, $rayo_atras, $rayo_izq2, $rayo_izq3, $rayo_izq4, $rayo_izq5,
	$rayo_izq6, $rayo_izq7, $rayo_izq8, $rayo_izq9, $rayo_izq10, $rayo_izq11,
	$rayo_izq12, $rayo_der2, $rayo_der3, $rayo_der4, $rayo_der5, $rayo_der6,
	$rayo_der7, $rayo_der8, $rayo_der9, $rayo_der10, $rayo_der11, $rayo_der12,
	$rayo_frente2, $rayo_atras2, $rayo_izq13, $rayo_izq14, $rayo_izq15,
	$rayo_izq16, $rayo_izq17, $rayo_izq18, $rayo_izq19, $rayo_izq20, $rayo_izq21,
	$rayo_izq22, $rayo_izq23, $rayo_der13, $rayo_der14, $rayo_der15, $rayo_der16,
	$rayo_der17, $rayo_der18, $rayo_der19, $rayo_der20, $rayo_der21, $rayo_der22,
	$rayo_der23
]
@onready var zona_disparo = $Area3D
@onready var bala = load("res://bala disparo.tscn")
@export var velocidad = 8.0
@onready var spawn_bala = $arma
@onready var chispa_disparo = $arma/GPUParticles3D
@onready var alistar_arma = $arma/arma_lista
@onready var sonido_disparo = $arma/shoot

var salud = 100
var esta_vivo = true
var he_visto_al_jugador = false
var jugador:CharacterBody3D = null
var direccion = Vector3.ZERO
var tiempo_cambio_rumbo = 0.0
var vel_actual = velocidad

var tiempo_perdido = 0.0
@export var tiempo_gracia_perdida = 0.5

var temporizador_disparo = 0.0
var tiempo_entre_rafagas = 3.0
var esta_disparando = false

func _ready():
	vida.iniciar_salud(salud)
	anims.play("idle")
	sombra.play("idle")
	respiracion.play()
	jugador = get_tree().get_first_node_in_group("jugador")
	elegir_ruta()

func _physics_process(delta):
	if not esta_vivo:
		return
		
	velocity.y -= 9.8 * delta
	
	var jugador_detectado = false
	for rayo in rayos:
		if rayo.is_colliding():
			var deteccion = rayo.get_collider()
			if deteccion != null and deteccion.is_in_group("jugador") and esta_vivo:
				jugador_detectado = true
				break
	
	if jugador_detectado:
		tiempo_perdido = tiempo_gracia_perdida
		if not he_visto_al_jugador:
			print("CUERPO EN MOVIMIENTO")
			he_visto_al_jugador = true
			anims.play("walk")
			sombra.play("walk")
	else:
		if he_visto_al_jugador:
			tiempo_perdido -= delta
			if tiempo_perdido <= 0.0:
				print("YA NO TE VEO")
				he_visto_al_jugador = false
				anims.play("idle")
				sombra.play("idle")
				respiracion.play()
				elegir_ruta()
	
	if he_visto_al_jugador and jugador != null:
		if not esta_disparando:
			temporizador_disparo += delta
			if temporizador_disparo >= tiempo_entre_rafagas:
				disparar()
			tiempo_cambio_rumbo -= delta
		
			if tiempo_cambio_rumbo <= 0:
				elegir_ruta()
				vel_actual = velocidad
				velocity.x = direccion.x * vel_actual
				velocity.z = direccion.z * vel_actual
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		vel_actual = 0.0
		velocity.x = 0.0
		velocity.z = 0.0
	move_and_slide()

func disparar():
	esta_disparando = true
	temporizador_disparo = 0.0
	
	anims.play("prepare")
	sombra.play("prepare")
	await(anims.animation_finished)
	alistar_arma.play()
	await(get_tree().create_timer(1.0).timeout)
	
	for i in range(3):
		if not esta_vivo or not he_visto_al_jugador:
			break
		instanciar_bala()
		await(get_tree().create_timer(0.5).timeout)
	
	esta_disparando = false
	if esta_vivo and he_visto_al_jugador:
		anims.play("walk")
		sombra.play("walk")
		elegir_ruta()

func instanciar_bala():
	if bala == null or jugador == null:
		return
	var camara = get_viewport().get_camera_3d()
	if camara != null:
		var cam_derecha = camara.global_transform.basis.x.normalized()
		var offset_horizontal = 0.2
		var offset_vertical = 0.2
		var pos_origen = global_position + (cam_derecha * offset_horizontal) + (Vector3.UP * offset_vertical)
		spawn_bala.global_position = pos_origen
		
	
	chispa_disparo.restart()
	sonido_disparo.play()
	var destino = jugador.global_position
	destino.y = 0.3
	spawn_bala.look_at(destino, Vector3.UP)
	var bullet = bala.instantiate()
	bullet.emisor = self
	get_parent().add_child(bullet)
	bullet.global_transform = spawn_bala.global_transform

func elegir_ruta():
	var angulo = randf_range(0, 2 * PI)
	direccion = Vector3(cos(angulo),0,sin(angulo)).normalized()
	tiempo_cambio_rumbo = randf_range(2.0,0.0)

func recibir_daño(bala, dir_empuje = Vector3.ZERO):
	if not esta_vivo:
		return
	emit_signal("Soy_malo")
	print("Auch... me duele")
	velocity.x += dir_empuje.x * 8.0
	velocity.z += dir_empuje.z * 8.0
	
	var nueva_salud = salud - bala.daño
	salud = nueva_salud
	if is_instance_valid(vida):
		vida.set_salud(salud)
	if nueva_salud <= 0:
		emit_signal("muerto")
		anims.play("die")
		sombra.play("die")
		respiracion.stop()
		muerte.play()
		esta_vivo = false
		collision_layer = 0
		collision_mask = 0
		set_physics_process(false)
		velocity = Vector3.ZERO
		sprite_vida.queue_free()
		#var ruta = item_dropeables.pick_random()
		#var escena = load(ruta)
		#var item = escena.instantiate()
		#get_parent().add_child(item)
		#item.global_transform.origin = global_transform.origin
