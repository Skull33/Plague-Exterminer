extends Node3D

@onready var particulas = $GPUParticles3D
var disparar = false

func _ready():
	Dialogic.connect("timeline_started",Callable(self,"inicio_dialogo"))
	Dialogic.connect("timeline_ended", Callable(self, "fin_dialogo"))

func _physics_process(delta):
	for jugador in get_tree().get_nodes_in_group("jugador"):
		if jugador.puede_disparar == false:
			disparar = false
		else:
			disparar = true
	if Input.is_action_just_pressed("disparar") and disparar:
		particulas.restart()

func inicio_dialogo():
	disparar = false
	print("aqui no se dispara")

func fin_dialogo():
	print("ya puedes disparar")
	disparar = true
