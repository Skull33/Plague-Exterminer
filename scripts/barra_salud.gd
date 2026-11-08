extends ProgressBar

@onready var timer = $Timer
@onready var daño = $"Barra_daño"

var salud = 0 : set = set_salud

func set_salud(nueva_salud):
	var salud_restante = salud
	salud = min(max_value, nueva_salud)
	value = salud
	
	if salud < salud_restante:
		timer.start()
	else:
		daño.value = salud   

func iniciar_salud(_salud):
	salud = _salud
	max_value = salud
	value = salud
	daño.max_value = salud
	daño.value = salud


func _on_timer_timeout() -> void:
	daño.value = salud
