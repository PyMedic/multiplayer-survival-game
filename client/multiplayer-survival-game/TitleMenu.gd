extends Control

signal host_selected
signal join_selected
signal singleplayer_selected

@onready var host_btn = $TitleCenterContainer/GameMenu/HostButton
@onready var join_btn = $TitleCenterContainer/GameMenu/JoinButton
@onready var singleplayer_btn = $TitleCenterContainer/GameMenu/SinglePlayerButton

# Called when the node enters the scene tree for the first time.
func _ready():
	host_btn.pressed.connect(_on_host_pressed)
	join_btn.pressed.connect(_on_join_pressed)
	singleplayer_btn.pressed.connect(_on_singleplayer_pressed)

func _on_host_pressed():
	host_selected.emit()

func _on_join_pressed():
	join_selected.emit()

func _on_singleplayer_pressed():
	singleplayer_selected.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
