class_name Constants extends Node

enum AmmoType {
	AssaultRifle=0,
	SubMachineGun=1,
	ShotGun=2,
	SniperRifle=3,
	Launcher=4,
	Pistol=5
}

const AmmoScenes : Array[PackedScene] = [
	preload("res://Assets/Consumables/AssaultRifleAmmo.tscn"),
	preload("res://Assets/Consumables/LauncherAmmo.tscn"),
	preload("res://Assets/Consumables/PistolAmmo.tscn"),
	preload("res://Assets/Consumables/ShotGunAmmo.tscn"),
	preload("res://Assets/Consumables/SniperRifleAmmo.tscn"),
	preload("res://Assets/Consumables/SubMachineGun.tscn"),
]
const Consumables : Array[PackedScene] = [
	preload("res://Assets/Consumables/AssaultRifleAmmo.tscn"),
	preload("res://Assets/Consumables/LauncherAmmo.tscn"),
	preload("res://Assets/Consumables/PistolAmmo.tscn"),
	preload("res://Assets/Consumables/ShotGunAmmo.tscn"),
	preload("res://Assets/Consumables/SniperRifleAmmo.tscn"),
	preload("res://Assets/Consumables/SubMachineGun.tscn"),
]
const MoneyScene : PackedScene = preload("res://Assets/Consumables/Money.tscn")

static func GetRandomItemFromArray(partList : Array) -> Node:
	if (len(partList) == 0): return null
	return partList[randi_range(0, len(partList))-1].instantiate()

static func GenerateAmmo(placesNode : Node) -> void:
	var nodes : Array[Node] = placesNode.get_children()
	for node in nodes:
		var item : Node = Constants.GetRandomItemFromArray(AmmoScenes)
		node.add_child(item)

static func GenerateConsumable(placesNode : Node) -> void:
	var nodes : Array[Node] = placesNode.get_children()
	for node in nodes:
		var item : Node = Constants.GetRandomItemFromArray(Consumables)
		node.add_child(item)

static func GenerateMoney(placesNode : Node) -> void:
	var nodes : Array[Node] = placesNode.get_children()
	for node in nodes:
		var item : Node = MoneyScene.instantiate()
		node.add_child(item)
