extends Node2D

@onready var ui = $UI
@onready var game_world = $GameWorld
@onready var players = $Players
@onready var managers = $Managers

const TITLE_SCENE = preload("res://Title.tscn")
var title_instance: Control = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Display the Title scene first.
	title_instance = TITLE_SCENE.instantiate()
	ui.add_child(title_instance)
	
	# Connect the button signals from TitleMenu.gd
	title_instance.host_selected.connect(_on_host_selected)
	title_instance.join_selected.connect(_on_join_selected)
	title_instance.singleplayer_selected.connect(_on_singleplayer_selected)

func _on_host_selected():
	title_instance.queue_free()

	var gm_scene = preload("res://GameManager.tscn")
	var gm_instance = gm_scene.instantiate()
	managers.add_child(gm_instance)
	gm_instance.players_container = players
	
	print("_on_host_selected called.")

	gm_instance.host_game()
	
func _on_join_selected():
#	var join_panel_scene = preload("res://JoinPanel.tscn")
#	var join_panel_instance = join_panel_scene.instantiate()
#	ui.add_child(join_panel_instance)

#	join_panel_instance.populate_server_list(["127.0.0.1:9999"])
	print("_on_join_selected called.")
#	join_panel_instance.connect("server_chosen", Callable(self, "_on_server_chosen"))
	
func _on_server_chosen(ip: String):
	var gm_scene = preload("res://GameManager.tscn")
	var gm_instance = gm_scene.instantiate()
	managers.add_child(gm_instance)
	gm_instance.players_container = players

	gm_instance.join_game(ip)

	title_instance.queue_free()

func _on_singleplayer_selected():
	title_instance.queue_free()
	
	# Load the MainWorld scene.
	var world_scene = preload("res://MainWorld.tscn")
	var world_instance = world_scene.instantiate()
	game_world.add_child(world_instance)

	# Create GameManager
	var gm_scene = preload("res://GameManager.tscn")
	var gm_instance = gm_scene.instantiate()
	managers.add_child(gm_instance)
	gm_instance.players_container = players
	
	print("_on_singleplayer_selected called.")

	# Spawn local player.
	gm_instance.spawn_player(gm_instance.multiplayer.get_unique_id(), true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
