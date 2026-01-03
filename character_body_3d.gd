class_name EsJugador
extends CharacterBody3D
signal persigueme

@export var velocidad = 10.0
@onready var cabeza = $cabeza
@export var fuerza_salto = 7.0
@export var gravedad = 9.8
@onready var salud = $Barra_Salud
@onready var estado_de_salud = $Barra_Salud/Sprite2D
@onready var cuerpo = $CollisionShape3D
@onready var camara = %Camera3D
@onready var puntero = $TextureRect
@onready var icono = $icono
var sonar = false
var nueva_salud
var bala = preload("res://bala disparo.tscn")
@onready var spawners = [
	$"cabeza/sway/doble cañon/bulletSpawn",
	$"cabeza/sway/doble cañon/bulletSpawn2",
	$"cabeza/sway/doble cañon/bulletSpawn3",
	$"cabeza/sway/doble cañon/bulletSpawn4",
	$"cabeza/sway/doble cañon/bulletSpawn5"
]
@onready var shotgun_audio = $"cabeza/sway/doble cañon/disparar"
@onready var escopeta = $"cabeza/sway/doble cañon"
@onready var quejidos = $quejidos
@onready var muerte = $muerte
@onready var timer_quejidos = $Timer_quejidos
@onready var quejidos_array = [
	"res://audio/quejido_prota 1.mp3",
	"res://audio/quejido_prota 2.mp3",
	"res://audio/quejido_prota 3.mp3"
]
@onready var municion = $CanvasLayer/Municion

var sensibilidad = 0.1
var rotacion = 0.0
var puede_moverse = true
var puede_disparar = false
var tiene_la_llave_azul = false
var estamos_vivos = true
var camara_caida_velocidad = Vector3.ZERO
var camara_esta_cayendo = false
var gravedad_camara = 20.0
#cabeceo
@export_group("cabeceo")
@export var frecuencia_cabeceo = 2.0
@export var amplitud_cabeceo = 0.04
var tiempo_cabeceo = 0.0
@export var cantidad_salud = 100
var tiene_la_escopeta = false
@export var municion_maxima = 50
@export var municion_minima = 0
@export var municion_actual = 0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotacion -= event.relative.y * sensibilidad
		rotacion = clamp(rotacion, -90, 90)
		rotation_degrees.y -= event.relative.x * sensibilidad
		cabeza.rotation_degrees.x = rotacion

func _ready():
	emit_signal("persigueme")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Dialogic.connect("timeline_started",Callable(self,"inicio_dialogo"))
	Dialogic.connect("timeline_ended", Callable(self, "fin_dialogo"))
	salud.iniciar_salud(cantidad_salud)
	municion.hide()
	icono.hide()
	escopeta.hide()

func inicio_dialogo():
	puede_moverse = false
	puede_disparar = false
	velocidad = 0.0
	print("estas detenido")

func fin_dialogo():
	print("ya te puedes mover")
	velocidad = 5.0
	puede_moverse = true
	puede_disparar = true

func _physics_process(delta):
	if estamos_vivos:
		#todo esto es el salto, osea el eje Y
		if not is_on_floor():
			velocity.y -= gravedad * delta
		if is_on_floor() and Input.is_action_just_pressed("Saltar"):
			velocity.y = fuerza_salto
		#todo esto es el movimiento en el suelo, osea el eje X y Z
		var direccion = Vector3.ZERO
		
		if Input.is_action_pressed("Adelante"):
			direccion -= transform.basis.z
		if Input.is_action_pressed("Atras"):
			direccion += transform.basis.z
		if Input.is_action_pressed("Derecha"):
			direccion += transform.basis.x
		if Input.is_action_pressed("Izquierda"):
			direccion -= transform.basis.x
		if tiene_la_escopeta:
				municion.show()
				icono.show()
				municion.text = str(municion_actual)
				if municion_actual > municion_maxima:
					for municiones in get_tree().get_nodes_in_group("municion"):
						if municiones.has_signal("Aumentar_ammo"):
							municion_actual += municiones.añadir_municion
				if municion_actual > municion_minima:
					puede_disparar = true
				if municion_actual == municion_minima:
					puede_disparar = false
				if puede_disparar:
					if Input.is_action_just_pressed("disparar") and puede_disparar:
						shotgun_audio.play()
						for spawn in spawners:
							var instanciar_bala = bala.instantiate()
							instanciar_bala.position = spawn.global_position
							instanciar_bala.transform.basis = spawn.global_transform.basis
							get_tree().get_current_scene().add_child(instanciar_bala)
						municion_actual -=1
						if municion_actual == 0:
							puede_disparar = false
		
		velocity.x = direccion.x * velocidad
		velocity.z = direccion.z * velocidad
		move_and_slide()
		#aqui hare el cabeceo del personaje
		tiempo_cabeceo += delta * velocity.length() * float(is_on_floor())
		camara.transform.origin = cabeceo(tiempo_cabeceo)
	if not estamos_vivos:
		velocity = Vector3.ZERO
		puede_disparar = false
		sensibilidad = 0
		puntero.hide()
		if not estamos_vivos and camara_esta_cayendo:
			camara_caida_velocidad.y -= gravedad_camara * delta
			camara.translate(camara_caida_velocidad * delta)
			camara.rotation_degrees.x += randf_range(-0.5, 0.5)
			camara.rotation_degrees.z += randf_range(-0.5, 0.5)
		if camara.global_position.y <= 0.01:
			camara_esta_cayendo = false

func cabeceo(tiempo_cabeceo):
	var posicion_cabeceo = Vector3.ZERO
	posicion_cabeceo.y = sin(tiempo_cabeceo * frecuencia_cabeceo) * amplitud_cabeceo
	posicion_cabeceo.x = cos(tiempo_cabeceo * frecuencia_cabeceo / 2) * amplitud_cabeceo
	return posicion_cabeceo

func hemos_sido_dañados(objeto_daño):
	print("me dieron, voy a morir")
	nueva_salud = cantidad_salud - objeto_daño.daño
	cantidad_salud = nueva_salud
	if is_instance_valid(salud):
		salud.set_salud(nueva_salud)
		reprocudcir_sonidos()
		actualizar_estado_de_salud()
	if nueva_salud <= 0:
		estamos_vivos = false
		escopeta.hide()
		cuerpo.disabled = true
		camara_esta_cayendo = true
		muerte.play()
		camara_caida_velocidad = Vector3(0, -2, 0)
		await(muerte.finished)
		Transicion.mostrar("res://escena de muerte.tscn")

func actualizar_estado_de_salud():
	var porcentaje = float(cantidad_salud) / 100.0
	if porcentaje > 0.9:
		estado_de_salud.frame = 0
	elif porcentaje > 0.75:
		estado_de_salud.frame = 1
	elif porcentaje > 0.5:
		estado_de_salud.frame = 2
	elif porcentaje > 0.3:
		estado_de_salud.frame = 3
	elif porcentaje > 0.1:
		estado_de_salud.frame = 4
	elif porcentaje <= 0:
		estado_de_salud.frame = 5

func obtener_arma():
	if not tiene_la_escopeta:
		tiene_la_escopeta = true
		escopeta.show()
		print("Has obtenido la escopeta")

func iniciar_tiempo_quejido():
	timer_quejidos.wait_time = 0.3
	timer_quejidos.start()

func terminar_quejido():
	reprocudcir_sonidos()

func reprocudcir_sonidos():
	timer_quejidos.stop()
	var indice_array = randi() % quejidos_array.size() - 1
	quejidos.stream = load(quejidos_array[indice_array])
	quejidos.play()
	iniciar_tiempo_quejido()

func _curar(puntos):
	cantidad_salud = clamp(cantidad_salud + puntos, 0, 100)
	salud.set_salud(cantidad_salud)
	actualizar_estado_de_salud()
