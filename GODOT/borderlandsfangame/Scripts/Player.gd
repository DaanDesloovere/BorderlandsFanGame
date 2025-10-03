extends CharacterBody3D

const SPEED : float = 5.0
const JUMP_VELOCITY : float = 4.5

@export var array : Array

@onready var hud = get_tree().root.get_node("Main/HUD") # adjust path
@onready var ray = $Camera/RayCast
var IsMouseCaptured: bool = false
var mouse_sensitivity : float = 0.002
var AmmoArray = {
	Constants.AmmoType.AssaultRifle : 0,
	Constants.AmmoType.SniperRifle : 0,
	Constants.AmmoType.Launcher : 0,
	Constants.AmmoType.Pistol : 0,
	Constants.AmmoType.ShotGun : 0,
	Constants.AmmoType.SubMachineGun : 0
}

var MaxAmmoArray = {
	Constants.AmmoType.AssaultRifle : 6,
	Constants.AmmoType.SniperRifle : 6,
	Constants.AmmoType.Launcher : 6,
	Constants.AmmoType.Pistol : 6,
	Constants.AmmoType.ShotGun : 6,
	Constants.AmmoType.SubMachineGun : 6
}

var MoneyAmount : int = 0

func _ready() -> void:
	CaptureMouse()

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera.rotation.x = clampf($Camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	if event.is_action_pressed("Menu") and IsMouseCaptured:
		ReleaseMouse()
	elif event.is_action_pressed("Menu") and !IsMouseCaptured:
		CaptureMouse()	
	
	if event.is_action_pressed("Interact"):
		Interact()
	if event.is_action_pressed("GenerateGun"):
		GenerateGun()
	if event.is_action_pressed("GenerateAmmo"):
		GenerateAmmo()
	if event.is_action_pressed("GenerateMoney"):
		GenerateMoney()
	if event.is_action_pressed("ReloadScene"):
		ReloadScene()

func _physics_process(delta: float) -> void:
	hud.ProcessQueue($Camera)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forwards", "Backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#region Mouse Functions
func CaptureMouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	IsMouseCaptured = true

func ReleaseMouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	IsMouseCaptured = false
#endregion

#region Interact Functions
func Interact() -> void:
	if ray.is_colliding():
		var obj : Node3D = ray.get_collider()
		if obj and obj.has_method("Open"):
			obj.Open()

func PickupAmmo(type: Constants.AmmoType, amount: int) -> void:
	AmmoArray[type] += amount
	hud.AddToQueue(Constants.HudPickupType.Ammo, str(amount))

func PickupMoney(amount: int) -> void:
	MoneyAmount += amount
	hud.AddToQueue(Constants.HudPickupType.Money, str(amount))


func GenerateGun() -> void:
	pass

func GenerateMoney() -> void:
	var node = Constants.MoneyScene.instantiate()
	get_tree().get_root().add_child(node)

func GenerateAmmo() -> void:
	var ammo : Node = Constants.GetRandomItemFromArray(Constants.AmmoScenes)
	if (ammo == null):
		return
	get_tree().get_root().add_child(ammo)

func ReloadScene() -> void:
	get_tree().reload_current_scene()

#endregion
