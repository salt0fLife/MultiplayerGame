extends Control




func _on_join_existing_game_button_down():
	var ValidIp = false
	var inputIP = $VBoxContainer/LineEdit.text
	var validIPList = IP.get_local_addresses()
	
	for address in validIPList:
		if inputIP == address:
			#valid ip can continue
			ValidIp = true
			break
			pass
		else:
			#not a match try next
			pass
		pass
	
	if not ValidIp:
		print("the entered ip does not exist on the network")
		$output.text += "\n console: the entered ip does not exist on the network. double check your input and make sure your on the same network"
		pass
	else:
		MultiplayerHandler.joinGame(inputIP)
		self.queue_free()
	pass


func _on_host_game_button_down():
	MultiplayerHandler.hostGame()
	self.queue_free()
	pass # Replace with function body.
