extends Control
class_name SlotUI

## Represents a [Slot] visually with item [Texture2D] and amount [Label]

@onready var item_icon : TextureRect = get_node(NodePath("Item Icon"))
@onready var amount_label : Label = get_node(NodePath("Amount"))
@onready var selection_background : Panel = get_node(NodePath("Selected"))

## Color when mouse enter
@export var highlight_color = Color.ORANGE


## Update information with [Dictionary] slot. 
## If the item is null, the slot does not display its information, useful for fixed [Inventory].
## The amount label is only displayed if amount is greater than 1
func update_info_with_slot(slot : Dictionary, database : InventoryDatabase):
	if slot.has("item_id") and slot.item_id >= InventoryItem.NONE:
		# TODO Slow call, use cache from node inv base
		var item = database.get_item(slot.item_id)
		if item != null:
			update_info_with_item(item, slot.amount)
			return
	item_icon.texture = null
	amount_label.visible = false


## Update information with [InventoryItem] and amount.
## If the item is null, the slot does not display its information, useful for fixed [Inventory].
## The amount label is only displayed if amount is greater than 1
func update_info_with_item(item : InventoryItem, amount := 1):
	if item != null:
		item_icon.texture = item.icon
		tooltip_text = item.name
	else:
		item_icon.texture = null
		tooltip_text = ""
	amount_label.text = str(amount)
	amount_label.visible = amount > 1


## Clear info slot information
func clear_info():
		item_icon.texture = null
		amount_label.visible = false
		

func set_selection(is_selected : bool):
	selection_background.visible = is_selected


func _on_mouse_entered():
	$Panel.self_modulate = highlight_color


func _on_mouse_exited():
	$Panel.self_modulate = Color.WHITE


func _on_hidden():
	$Panel.self_modulate = Color.WHITE