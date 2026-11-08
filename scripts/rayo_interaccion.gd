extends RayCast3D

@onready var texto = $Label

func _ready():
	add_exception(owner)
	
func _physics_process(_delta):
	texto.text = ""
	if is_colliding():
		var deteccion = get_collider()
		
		if deteccion.is_in_group("Puertas_Azules"):
			texto.text = deteccion.mensaje
			if Input.is_action_just_pressed("Interaccion"):
				deteccion.hacer_texto()
		elif deteccion.is_in_group("Puertas"):
			texto.text = deteccion.mensaje
			if Input.is_action_just_pressed("Interaccion"):
				deteccion.hacer_texto()
		elif deteccion.is_in_group("armas"):
			texto.text = deteccion.msg
			if Input.is_action_just_pressed("Interaccion"):
				deteccion.hacer_texto()
		elif deteccion.is_in_group("es destructible"):
			texto.text = deteccion.mensaje
			if Input.is_action_just_pressed("Interaccion"):
				deteccion._interaccion_sin_destruir()
		elif deteccion.is_in_group("objtos_curativos"):
			texto.text = deteccion.mensaje
			if Input.is_action_just_pressed("Interaccion"):
				deteccion.Aumentar_salud()
