extends StaticBody3D
class_name MovableObject

func disable_collision(boolean: bool):
	$CollisionShape3D.disabled = boolean
