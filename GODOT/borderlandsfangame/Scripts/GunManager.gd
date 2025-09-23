extends Node

@export var BodyParts : Array
@export var BarrelParts : Array
@export var StockParts : Array
@export var GripParts : Array

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GenerateGun"):
		GenerateGun()

func GenerateGun():
	var gun = Node3D.new()
	# random parts gathered and assembled and instantiated as 1 gun
	var bodyInstance = GetRandomPart(BodyParts)
	var barrelInstance = GetRandomPart(BarrelParts)
	var stockInstance = GetRandomPart(StockParts)
	var gripInstance = GetRandomPart(GripParts)
	
	if (bodyInstance == null || barrelInstance == null 
		|| stockInstance == null || gripInstance == null):
		return
	
	gun.add_child(bodyInstance)
	gun.add_child(barrelInstance)
	gun.add_child(stockInstance)
	gun.add_child(gripInstance)
	
	add_child(gun)

func GetRandomPart(partList : Array) -> Node:
	if (len(partList) == 0): return null
	return partList[randi_range(0, len(partList))-1].instantiate()
