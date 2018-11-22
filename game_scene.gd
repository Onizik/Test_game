extends Node

var roads_number = 8
var current_road = 2
var speed = 10

var screen_height
var screen_width
var road_width
var player_size

var enemy = preload("res://enemy.tscn")

func _ready():
	screen_height = ProjectSettings.get_setting("display/window/size/height")
	screen_width = ProjectSettings.get_setting("display/window/size/width")
	player_size = $player/sprite.texture.get_size() * $player/sprite.scale
	player_size = $player/sprite.texture.get_size() * $player/sprite.scale
	road_width = $roads/road1.texture.get_size().x * $roads/road1.scale.x

func _process(delta):
	var road_offset = 0
	var y_offset = 0
	
	if Input.is_action_just_pressed("left_key"):
		road_offset -= 1
	if Input.is_action_just_pressed("right_key"):
		road_offset += 1
		
	if Input.is_action_pressed("up_key"):
		y_offset -= 1
	if Input.is_action_pressed("down_key"):
		y_offset += 1
	y_offset *= speed
	_set_player_position(y_offset)
	_set_road(road_offset)

func _set_player_position(y_offset):
	$player.position.y += y_offset
	var max_y = screen_height - (player_size.y / 2)
	var min_y = player_size.y / 2
	$player.position.y = clamp($player.position.y, min_y, max_y)

func _set_road(road_offset):
	var x_offset = road_offset * road_width 
	$player.position.x += x_offset
	var max_x = screen_width - (road_width / 2)
	var min_x = road_width / 2
	$player.position.x = clamp($player.position.x, min_x, max_x)
	
func _generate_enemy():
	var road_position = (randi() % (roads_number - 1)) + 1
	var new_enemy = enemy.instance()
	new_enemy.position.y = -100
	new_enemy.position.x = (road_position - 0.5) * road_width
	new_enemy.speed += (randi() %50) - 10
	add_child(new_enemy)

func _on_player_area_entered(area):
	get_tree().change_scene("res://lose.tscn")


func _on_enemy_spawner_timeout():
	_generate_enemy()
