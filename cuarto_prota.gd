extends Node3D

@onready var jugador = get_tree().get_first_node_in_group("jugador")
@onready var musica_nivel = $Jugador/AudioStreamPlayer3D2
@onready var evento = $Area3D

var musica_iniciada = false

func _ready():
	evento.body_entered.connect(entro)

func _process(_delta):
	if jugador.tiene_la_escopeta and not musica_iniciada:
		musica_nivel.play()
		var tween = get_tree().create_tween()
		tween.tween_property(musica_nivel,"volume_db",20,3)
		musica_iniciada = true
	if evento.horda_terminada:
		await (get_tree().create_timer(5).timeout)
		var tween = get_tree().create_tween()
		tween.tween_property(musica_nivel,"volume_db",20,3)

func entro(cuerpo):
	if cuerpo is EsJugador:
		var tween = get_tree().create_tween()
		tween.tween_property(musica_nivel,"volume_db",-80,3)
