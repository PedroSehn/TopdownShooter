extends CharacterBody2D
@onready var rayCast2D = $RayCast2D
@export var moveSpeed = 200
var dead = false

func _process(delta):
	if(Input.is_action_just_pressed("exit")):
		get_tree().quit()
	if(Input.is_action_just_pressed("restart")):
		restart()
	if(dead):
		return
		
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	
	if(Input.is_action_just_pressed("shoot")):
		shoot()

func _physics_process(delta):
	if dead:
		return
	var moveDir = Input.get_vector("move-left", "move-right", "move-up", "move-down")
	velocity = moveDir * moveSpeed
	move_and_slide()

func kill():
	if(dead):
		return
	dead = true
	$DeathSound.play()
	$Graphics/Dead.show()
	$Graphics/Alive.hide()
	$CanvasLayer/DeathScreen.show()
	z_index = -1

func shoot():
	$MuzzleFlash.show()
	$MuzzleFlash/Timer.start()
	$ShootSound.play()
	if(rayCast2D.is_colliding() and rayCast2D.get_collider().has_method("kill")):
		rayCast2D.get_collider().kill()
func restart():
	get_tree().reload_current_scene()
