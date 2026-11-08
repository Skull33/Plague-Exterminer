extends Control

@onready var boton = $Button
@onready var boton2 = $Button2
@onready var animacion = $AnimationPlayer
@onready var audio: Array = [
	"res://audio/Muerte_1.mp3",
	"res://audio/Muerte_2.mp3"
]
@onready var reflexion_timer = $Timer
@onready var streamer = $AudioStreamPlayer2D

func _ready():
	animacion.play("texto")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	reproducir_sonidos()
	boton.disabled = true
	boton.visible = false
	boton2.disabled = true
	boton2.visible = false
	await(animacion.animation_finished)
	boton.disabled = false
	boton.visible = true
	boton2.disabled = false
	boton2.visible = true
	boton.pressed.connect(Boton_presionado)
	boton2.pressed.connect(Boton2_presionado)

func Boton_presionado():
	get_tree().change_scene_to_file("res://cuarto_prota.tscn")

func Boton2_presionado():
	get_tree().change_scene_to_file("res://escena_menu.tscn")

func iniciar_tiempo_quejido():
	reflexion_timer.wait_time = 0.5
	reflexion_timer.start()

func terminar_quejido():
	reproducir_sonidos()

func reproducir_sonidos():
	reflexion_timer.stop()
	var indice_array = randi() % audio.size() - 1
	streamer.stream = load(audio[indice_array])
	streamer.play()
	iniciar_tiempo_quejido()
