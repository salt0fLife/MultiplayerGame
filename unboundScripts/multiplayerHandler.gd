extends Node

var playerScene = preload("res://playerStuff/player.tscn")
var peer = ENetMultiplayerPeer.new()
var isServer = false
var playerList = []


#func _ready():
	#if multiplayer.is_server():
		#print_once_per_client.rpc()
#
#@rpc
#func print_once_per_client():
	#print("I will be printed to the console once per each connected client.")

func hostGame():
	#get_tree().change_scene_to_file("res://worlds/test_lobby.tscn")
	peer.create_server(8081)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(addPlayerCharacter)
	multiplayer.peer_connected.connect(_connected)
	addPlayerCharacter()
	isServer = true
	pass


func joinGame(ip):
	#get_tree().change_scene_to_file("res://worlds/test_lobby.tscn")
	peer.create_client(ip, 8081)
	multiplayer.multiplayer_peer = peer
	pass

func _connected():
	print("a Player Joined!")
	print("players = " + str(multiplayer.get_peers()))
	

func addPlayerCharacter(id = 1):
	var player = playerScene.instantiate()
	player.name = str(id)
	add_child(player)
	#var world = get_tree().get_first_node_in_group("MultiplayerSpawner")
	#world.add_child(player)
	#get_tree().root.add_child(player)
	#world.add_child(player)
	pass

func dieAnimation():
	$AnimationPlayer.play("deathScreen")
	pass

