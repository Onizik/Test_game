extends Node

var roads_number = 4
var current_road = 2
var speed = 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var road_offset = 0
	var y_offset = 0
	
	if Input.action_press("left_key"):
		road_offset += 1
	if Input.action_press("right_key"):
		road_offset -= 1
		
	if Input.is_action_pressed("up_key"):
        y_offset += 1
	if Input.is_action_pressed("down_key"):
        y_offset -= 1
	y_offset *= speed
	_set_player_position(y_offset)

func _set_player_position(y_offset):
	$player.position.y += y_offset
	var current_y = $player.position.y 
	var max_y = get_viewport_rect().size.y - ($player.texture.get_size().y / 2)
	var min_y = $player.texture.get_size().y / 2
	$player.position.y = clamp($player.position.y, min_y, max_y)