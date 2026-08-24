extends Node3D

@onready var jugador = get_tree().get_first_node_in_group("jugador")
@onready var musica_nivel = $Jugador/AudioStreamPlayer3D2
@onready var evento = $Area3D
@onready var destruccion = $destruccion
@onready var anims_escena = $NavigationRegion3D/Dormitorio_viejo2/AnimationPlayer
@onready var col_destruccion = $destruccion/CollisionShape3D
@onready var audio_derrumbe = $AudioStreamPlayer3D
@onready var puerta_rosa = $"puerta dpto/Cube_015/StaticBody3D"

var musica_iniciada = false
var entro_al_evento = false

func _ready():
	evento.body_entered.connect(entro)
	destruccion.body_entered.connect(destruir)

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

func destruir(cuerpo):
	if cuerpo is EsJugador and not entro_al_evento:
		print("derrumbe")
		anims_escena.play("destruir")
		audio_derrumbe.play()
		puerta_rosa.destuir()
		puerta_rosa.roto_col_1.disabled = false
		puerta_rosa.roto_col_2.disabled = false
		entro_al_evento = true
