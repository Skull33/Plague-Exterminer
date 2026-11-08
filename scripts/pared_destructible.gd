class_name Destruir
extends StaticBody3D

signal SOY_destructible
@export var particulas: GPUParticles3D
@export var audio: AudioStreamPlayer3D
@export var colision: CollisionShape3D
@export var muro : MeshInstance3D
@export var sprite_aviso = Sprite3D
var mensaje = "[color=black]Analizar muro [E][/color]"
var interacted = false

func _destruccion():
	emit_signal("SOY_destructible")
	audio.play()
	muro.visible = false
	colision.disabled = true
	sprite_aviso.visible = false
	particulas.restart()
	await(get_tree().create_timer(particulas.lifetime).timeout)
	queue_free()

func _interaccion_sin_destruir():
	emit_signal("SOY_destructible")
	interacted = true
	if interacted:
		mensaje = "[color=black]Necesito un[/color] [color=red]ARMA O HERRAMIENTA[/color] [color=black]para \n destruir este muro viejo[/color]"
		await(get_tree().create_timer(1).timeout)
		interacted = false
	if not interacted:
		mensaje = "[color=black]Analizar muro [E][/color]"
	return mensaje
