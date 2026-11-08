extends AnimationPlayer

@onready var anims = self

func _ready():
	anims.play("alerta")
