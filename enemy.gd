extends Area2D

export (int) var speed = 75
var max_y

func _ready():
	max_y = ProjectSettings.get_setting("display/window/size/height")

func _process(delta):
	self.position.y += speed * delta
	if self.position.y > max_y:
		queue_free()