extends Resource
class_name ITEM_BAR_ITEM

enum ITEM_TYPES{HOE, WATERING_CAN, SEED, SHEARER}
enum ITEM_ID_TYPES{HOE, WATERING_CAN, CARROT_SEED, SHEARER}

@export var itemID: ITEM_ID_TYPES
@export var texture: CompressedTexture2D
@export var itemType: ITEM_TYPES
@export var plantResource: Resource
@export var value: int = 1
