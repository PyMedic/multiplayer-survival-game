extends Node

# Get the Players container node from the Main scene.
@onready var players_container = $"../Players"

const PLAYER_SCENE = preload("res://player.tscn")

# Store the current player(s)
# key: peer_id, value: player node
var spawned_players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn a player for the single play testing.
	# spawn_player(1, true)

	# Multiplayer event handling
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_connected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

	#host_game()
	#join_game("127.0.0.1)

func host_game(port: int = 9999):
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(port)

	if result != OK:
		print("Failed to host game. Error code: ", result)
		return

	multiplayer.multiplayer_peer = peer
	print("Hosting game on port: ", port)

	# Create the host player.
	var my_peer_id = multiplayer.get_unique_id()
	spawn_player(my_peer_id, true)

func join_game(ip: String, port: int = 9999):
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(ip, port)

	if result != OK:
		print("Failed to join the game. Error code: ", result)
		return

	multiplayer.multiplayer_peer = peer
	print("Joining the game at: ", ip, ":", port)

# Spawn player.
# peer_id: ID for each player in the multiplayer mode.
# is_local: Indicates whether the spawned player is the local player or not.

func spawn_player(peer_id: int, is_local: bool):
	# If the target player is already created, don't create it again.
	if spawned_players.has(peer_id):
		return

	var player = PLAYER_SCENE.instantiate()
	player.name = str(peer_id)
	player.global_position = Vector2(100 + peer_id * 50, 100)

	# Add the new player node under the Players container.
	players_container.add_child(player)

	spawned_players[peer_id] = player

	print("Spawned player: peer_id: ", peer_id, " | local: ", is_local)

# Remove player
func remove_player(peer_id: int):
	# If the peer_id does not exist in the spawned_players dictionary,
	# don't do anything.
	if not spawned_players.has(peer_id):
		return

	var player = spawned_players[peer_id]
	# Safely delete this player.
	player.queue_free()
	spawned_players.erase[peer_id]

	print("Removed the player with peer_id: ", peer_id)

# Multiplayer Event Handler Functions
func _on_peer_connected(id: int):
	# For test logging
	print("Peer connected: id: ", id)

	# For testing purpose, new player is created only on the server side.
	if multiplayer.is_server():
		spawn_player(id, false)

func _on_peer_disconnected(id: int):
	print("Peer disconnected: id: ", id)

	if multiplayer.is_server():
		remove_player(id)

func _on_connected_to_server():
	print("Connected to server successfully.")

	# Create the client's player.
	var my_peer_id = multiplayer.get_unique_id()
	spawn_player(my_peer_id, true)

func _on_connection_failed():
	print("Failed to connect to server.")

func _on_server_disconnected():
	print("Disconnected from server.")
