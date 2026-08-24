extends CharacterBody3D

@onready var area_daño = $Area3D
var velocidad = 50
var daño = 8
@onready var jugador = get_tree().get_first_node_in_group("jugador")

var emisor: Node3D = null

func _ready():
	area_daño.body_entered.connect(entro_area_daño)
	add_collision_exception_with(emisor)

func _process(delta):
	var direccion_frente = -global_transform.basis.z.normalized()
	var movimiento = direccion_frente * velocidad * delta
	var colision = move_and_collide(movimiento)
	if colision:
		var cuerpo = colision.get_collider()
		if cuerpo != emisor:
			entro_area_daño(cuerpo)

func entro_area_daño(cuerpo):
	if cuerpo == null or cuerpo == emisor:
		return
	elif cuerpo.is_in_group("Puertas_Azules"):
		print("algo interactuable")
		queue_free()
	elif cuerpo.is_in_group("jugador"):
		if cuerpo.has_method("hemos_sido_dañados"):
			jugador.hemos_sido_dañados(self)
		else:
			# Por si acaso el método esté en el nodo raíz del jugador
			var jug = get_tree().get_first_node_in_group("jugador")
			if jug and jug.has_method("hemos_sido_dañados"):
				jug.hemos_sido_dañados(self)
		queue_free()
		return
	elif cuerpo.is_in_group("enemigos"):
		var direccion_disparo = (transform.basis * Vector3(0,0,-1)).normalized()
		cuerpo.recibir_daño(self, direccion_disparo)
		queue_free()
		return
	elif cuerpo.is_in_group("es destructible"):
		cuerpo._destruccion()
		queue_free()
		return
	elif cuerpo.is_in_group("mundo"):
		queue_free()
		return
