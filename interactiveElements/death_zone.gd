extends Area3D



func _on_body_entered(body):
	if body.has_method("die"):
		body.die()
		pass
	pass # Replace with function body.
