extends Sprite3D

@onready var area_llave = $Area3D
@onready var sprite = $"."
@onready var audio_llave = $AudioStreamPlayer3D

func _ready():
	area_llave.body_entered.connect(tenemos_la_llave_azul)

func tenemos_la_llave_azul(cuerpo):
	if cuerpo is EsJugador:
		sprite.visible = false
		audio_llave.play()
		await(audio_llave.finished)
		queue_free()
		
		var puerta_mas_cercana = null
		var menor_distancia = INF
		
		for puerta in get_tree().get_nodes_in_group("Puertas_Azules"):
			if puerta is StaticBody3D:
				var dist = global_position.distance_to(puerta.global_position)
				if dist < menor_distancia:
					menor_distancia = dist
					puerta_mas_cercana = puerta
				
		if puerta_mas_cercana:
			puerta_mas_cercana.llave = true
			puerta_mas_cercana.es_azul = true
