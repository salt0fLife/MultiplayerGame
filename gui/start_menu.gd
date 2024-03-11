extends Control

func _ready():
	print("startMenu loaded")
	pass



func _on_settings_button_down():
	pass # Replace with function body.


func _on_single_player_button_down():
	MultiplayerHandler.addPlayerCharacter()
	queue_free()
	pass # Replace with function body.


func _on_multiplayer_button_down():
	$"../MultiplayerMenu".visible = true
	queue_free()
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit(3)
	pass # Replace with function body.
