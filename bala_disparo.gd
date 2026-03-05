extends CharacterBody3D

@onready var area_daño = $Area3D
var velocidad = 50
var daño = 5
@onready var colision = $Area3D/CollisionShape3D
@onready var malla = $CollisionShape3D

func _ready():
	area_daño.body_entered.connect(entro_area_daño)

func _process(delta):
	position += transform.basis * Vector3(0,0, -velocidad) * delta


func entro_area_daño(cuerpo):
	if cuerpo is Malo:
		cuerpo.recibir_daño(self)
		queue_free()
	elif cuerpo.is_in_group("es destructible"):
		cuerpo._destruccion()
		queue_free()
	elif cuerpo is Interactuable_A:
		queue_free()
	elif cuerpo.is_in_group("mundo"):
		cuerpo._destruccion()
		queue_free()
