extends CanvasLayer

@onready var floating_numbers = $FloatingNumbers
var HudQueue : Array = []
var CurrentlyProcessing: int = 0
var boolTopSpot : bool = false
var boolMiddleSpot : bool = false
var boolBottomSpot : bool = false

func SpawnMoneyUpdate(amount: String, camera: Camera3D) -> void:
	var floating_scene = preload("res://Assets/UI/FloatingText.tscn")
	var text = floating_scene.instantiate()
	# make it appear in the bottom right hand corner
	text.global_position = camera.get_viewport().size - Vector2i(-60,150)
	text.get_child(0).text = "$" + amount
	floating_numbers.add_child(text)
	await get_tree().create_timer(3).timeout
	#set it as no longer processing
	CurrentlyProcessing -= 1

func SpawnAmmoUpdate(amount: String, camera: Camera3D) -> void:
	var floating_scene = preload("res://Assets/UI/FloatingText.tscn")
	var text = floating_scene.instantiate()
	
	# make it appear in the bottom right hand corner
	var yModifier: int = 0
	if (!boolTopSpot):
		yModifier = 1
		boolTopSpot = true
	elif (!boolMiddleSpot):
		yModifier = 2
		boolMiddleSpot = true
	elif (!boolBottomSpot):
		yModifier = 3
		boolBottomSpot = true
	
	var yPosition: int = 100 + 50*yModifier
	text.global_position = camera.get_viewport().size - Vector2i(-60,yPosition)
	text.get_child(0).text = amount + " ammo"
	floating_numbers.add_child(text)
	await get_tree().create_timer(4.5).timeout
	
	if (yModifier == 1):
		boolTopSpot = false
	elif (yModifier == 2):
		boolMiddleSpot = false
	elif (yModifier == 3):
		boolMiddleSpot = false
	#set it as no longer processing
	CurrentlyProcessing -= 1

func AddToQueue(type: Constants.HudPickupType, value: String):
	HudQueue.append({type : value})

func ProcessQueue(camera: Camera3D):
	if (CurrentlyProcessing < 3):
		if (HudQueue.size() == 0):
			pass
		elif (HudQueue[0].keys()[0] == Constants.HudPickupType.Money):
			CurrentlyProcessing += 1
			SpawnMoneyUpdate(HudQueue[0].values()[0], camera)
			HudQueue.remove_at(0)
		elif (HudQueue[0].keys()[0] == Constants.HudPickupType.Ammo):
			CurrentlyProcessing += 1
			SpawnAmmoUpdate(HudQueue[0].values()[0], camera)
			HudQueue.remove_at(0)
