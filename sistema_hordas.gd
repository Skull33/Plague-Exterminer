extends Area3D

@onready var zona_evento = $"."
@export var nro_enemigos_en_horda: int
@onready var audio_evento = $"../Jugador/AudioStreamPlayer3D"
@onready var ruina = $ruinas
@onready var sonido_ruina = $AudioStreamPlayer3D2
@onready var colision = $ruinas/Cube/StaticBody3D/CollisionShape3D
var enemigo_escena = preload("res://rat_minion.tscn")
var enemigos_generados: int = 0
var enemigos_vivos: int = 0
@export var spawners: Array[Marker3D] =[]

var inicio_horda = false
var horda_terminada = false
var muertes_para_spawn = 0
var limite_muertes = 0

func _ready():
	zona_evento.body_entered.connect(empezar_evento)

func empezar_evento(cuerpo):
	if cuerpo is EsJugador and not inicio_horda:
		inicio_horda = true
		sonido_ruina.play()
		var tween = get_tree().create_tween()
		tween.tween_property(audio_evento, "volume_db", 20, 5)
		audio_evento.play()
		spawnear_enemigos()
		print("Hora de la prueba")

func spawnear_enemigos():
	var spawners_cp:Array = spawners.duplicate()
	spawners_cp.shuffle()
	var c = randi_range(2, spawners_cp.size())
	for i in range(c):
		var spawn = spawners_cp[i]
		print("se activaron los spawners ", spawn.name)
		if enemigos_generados >= nro_enemigos_en_horda :
			break
		var enemigo = enemigo_escena.instantiate()
		print("limite para siguiente ronda ", limite_muertes)
		get_parent().add_child(enemigo)
		enemigo.global_transform.origin = spawn.global_transform.origin
		if enemigo.has_signal("muerto"):
			enemigo.connect("muerto", Callable(self, "_enemigo_muerto"))
		enemigos_generados += 1
		enemigos_vivos += 1

func _enemigo_muerto():
	muertes_para_spawn +=1
	enemigos_vivos -= 1
	print("Quedan vivos:", enemigos_vivos)
	if muertes_para_spawn >= limite_muertes and enemigos_generados < nro_enemigos_en_horda:
		muertes_para_spawn = 0
		var max_limite = max(1, min(3, enemigos_vivos))
		limite_muertes = randi_range(1, max_limite)
		spawnear_enemigos()
	if enemigos_generados == nro_enemigos_en_horda and enemigos_vivos == 0:
		horda_terminada = true
		for evento_final in get_tree().get_nodes_in_group("final_nivel"):
			print("Horda finalizada")
			if evento_final is StaticBody3D:
				evento_final._termino_todas_las_hordas = true
		var tween = get_tree().create_tween()
		tween.tween_property(audio_evento, "volume_db", -80, 3)
