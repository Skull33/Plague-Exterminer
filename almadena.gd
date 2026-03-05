extends Node3D

@onready var jugador = get_tree().get_first_node_in_group("jugador")
@onready var anims =  $AnimationPlayer
@onready var area_daño = $Sprite3D/Area3D
@onready var colision_daño = $Sprite3D/Area3D/CollisionShape3D

@export var tipo_arma :String = "mazo"

var puede_atacar = true
var daño = 25

func _ready():
	self.hide()
	area_daño.body_entered.connect(entro_area_daño)
	colision_daño.disabled = true

func _physics_process(delta):
	if Input.is_action_pressed("disparar") and puede_atacar:
		puede_atacar = false
		anims.play("ataque")
		await (get_tree().create_timer(1).timeout)
		colision_daño.disabled = false
		jugador.cabeza.rotation_degrees.x -= 10
		await(anims.animation_finished)
		anims.play("recoger_almadena")
		await(anims.animation_finished)
		anims.play("podemos atacar otra vez")
		await(anims.animation_finished)
		puede_atacar = true
		colision_daño.disabled = true

func entro_area_daño(cuerpo):
	if cuerpo is Malo:
		cuerpo.recibir_daño(self)
	elif cuerpo.is_in_group("es destructible"):
		cuerpo._destruccion()

func obtener_arma():
	if not jugador.tiene_la_almadena:
		jugador.tiene_la_almadena = true
		self.show()
		print("Has obtenido la almadena")
	else:
		self.show()
