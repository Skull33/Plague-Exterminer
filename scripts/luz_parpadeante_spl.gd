extends SpotLight3D

@onready var energia_base = light_energy

var tiempo_cambio = 0.1
var cronometro = 0.0

func _process(delta):
	cronometro += delta
	if cronometro >= tiempo_cambio:
		cronometro = 0.0
		
		if randf() > 0.4:
			light_energy = energia_base
			tiempo_cambio = randf_range(0.05,0.2)
		else:
			light_energy = randf_range(0.0,0.15)
			tiempo_cambio = randf_range(0.02,0.08)
