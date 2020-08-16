extends Node

#export var total_reduction = 9

var rng = RandomNumberGenerator.new()

class Need:
	var size = 20
	var name = ""
	var last = LastReduction
	var bar

enum LastReduction {SMALL, MEDIUM, LARGE}

onready var hunger = Need.new()
onready var love = Need.new()
onready var bloodlust = Need.new()
var needs = []

func _ready():
	rng.randomize()
	hunger.name = "Hunger"
	hunger.bar = get_node("GUI/GridContainer/HungerBar")
	hunger.last = LastReduction.SMALL
	love.name = "Love"
	love.bar = get_node("GUI/GridContainer/LoveBar")
	love.last = LastReduction.MEDIUM
	bloodlust.name = "Bloodlust"
	bloodlust.bar = get_node("GUI/GridContainer/BloodlustBar")
	bloodlust.last = LastReduction.LARGE
	needs.append(hunger)
	needs.append(love)
	needs.append(bloodlust)
	return

func won_minigame():
	
	return

#Reduce the need bars
func reduce_needs():
	var total = rng.randi_range(14, 18)
	var remainder = total
	var largest = total / 2
	var medium = total / 3
	remainder -= largest + medium
	var small = remainder
	
	for i in needs:
		if(i.last == LastReduction.SMALL):
			i.last = LastReduction.LARGE
			i.size -= largest
		elif(i.last == LastReduction.MEDIUM):
			i.last = LastReduction.SMALL
			i.size -= small
		else:
			i.last = LastReduction.MEDIUM
			i.size -= medium
		
		if(i.size > 0):
			i.bar.change_segment_number(i.size)
		else:
			print(i.name + " has depleted. Game Over.")
	
	return


func _on_Button_pressed():
	reduce_needs()
	return
