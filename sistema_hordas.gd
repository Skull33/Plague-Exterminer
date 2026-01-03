extends Area3D

@onready var zona_evento = $"."
@export var nro_enemigos_en_horda: int
@onready var audio_evento = $AudioStreamPlayer3D
@onready var ruina = $ruinas
@onready var sonido_ruina = $AudioStreamPlayer3D2
@onready var colision = $ruinas/Cube/StaticBody3D/CollisionShape3D
var enemigo_escena = preload("res://rat_minion.tscn")
var enemigos_generados: int = 0
var enemigos_vivos: int = 0
@export var spawners: Array[Marker3D] =[
	
]
var inicio_horda = false
var forma_original

func _ready():
	zona_evento.body_entered.connect(empezar_evento)
	forma_original = colision.shape
	colision.shape = null
	ruina.hide()

func empezar_evento(cuerpo):
	if cuerpo is EsJugador and not inicio_horda:
		inicio_horda = true
		ruina.show()
		colision.shape = forma_original
		sonido_ruina.play()
		audio_evento.play()
		spawnear_enemigos()
		print("Hora de la prueba")

func spawnear_enemigos():
	for spawn in spawners:
		if enemigos_generados >= nro_enemigos_en_horda:
			break
		var enemigo = enemigo_escena.instantiate()
		get_parent().add_child(enemigo)
		enemigo.global_transform.origin = spawn.global_transform.origin
		if enemigo.has_signal("muerto"):
			enemigo.connect("muerto", Callable(self, "_enemigo_muerto"))
		enemigos_generados += 1
		enemigos_vivos += 1

func _enemigo_muerto():
	enemigos_vivos -= 1
	print("Quedan vivos:", enemigos_vivos)
	if enemigos_generados < nro_enemigos_en_horda:
		spawnear_enemigos()
	if enemigos_generados == nro_enemigos_en_horda and enemigos_vivos == 0:
		for evento_final in get_tree().get_nodes_in_group("final_nivel"):
			print("Horda finalizada")
			if evento_final is StaticBody3D:
				evento_final._termino_todas_las_hordas = true
		var tween = get_tree().create_tween()
		tween.tween_property(audio_evento, "volume_db", -80, 8)
