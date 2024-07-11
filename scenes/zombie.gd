extends CharacterBody2D
@onready var rayCast = $RayCast2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

@export var moveSpeed = 100

var dead = false

func _physics_process(delta):
	if dead:
		return
	var dirToPlayer = global_position.direction_to(player.global_position)
	velocity = dirToPlayer * moveSpeed
	move_and_slide()
	
	global_rotation = dirToPlayer.angle() + PI/2.0
	
	if(rayCast.is_colliding() and rayCast.get_collider() == player):
		print('mati')
		player.kill()

func _enter_tree():
	print("entrei")


func kill():
	if dead:
		return
	dead = true
	$DeathSound.play()
	$Graphics/Dead.show()
	$Graphics/Alive.hide()
	$CollisionShape2D.disabled = true
	z_index = -1
