extends Node

# Get the Players container node from the Main scene.
@onready var players_container = $"../Players"

# Spawn player.
# peer_id: ID for each player in the multiplayer mode.
# is_local: Indicates whether the spawned player is the local player or not.
func spawn_player(peer_id: int, is_local:bool) -> Node:
	# Load player.tscn and create an instance.
	var player_scene = preload("res://player.tscn")
	var player_instance = player_scene.instantiate()
	
	player_instance.name = str(peer_id)
	player_instance.is_local_player = is_local
	
	players_container.add_child(player_instance)
	player_instance.global_position = Vector2(100, 100)
	
	return player_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn a player for the single play testing.
	spawn_player(1, true)
