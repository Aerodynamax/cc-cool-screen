-- -@meta

-- -@class ItemDetails: ItemDetails.DamageAndDurability, ItemDetails.MapColour
-- -@field name string The namespaced ID for this item, e.g. minecraft:dirt. See the Minecraft wiki for a list of vanilla item IDs.
-- -@field count number The number of items in the stack.
-- -@field nbt? string A hash of the NBT in the stack. While this does not expose any information about the item's NBT, it can be used as a way to compare items. If two items have the same name and nbt, then all other properties (e.g. durability, enchantment) will be the same.
-- -@field displayName string The translated display name of the item. This uses the server's language. This will typically be English on multi-player servers, and your current language on single player.
-- -@field lore string[] Additional lore about this item, as a list of strings.
-- -@field maxCount number The max possible size of the item stack.
-- -@field tags { [string]: boolean } The set of tags for this item. This is a mapping of tag name to true.
-- -@field itemGroups ItemDetails.ItemGroup[] The item groups this item appears on. Each item group is stored as a table, containing its id and display name. (The creative tabs this item appears on)
-- -@field enchantments ItemDetails.Enchantment[] The enchantments this item has.
-- -@field potionEffects ItemDetails.PotionEffect[] The effects this potion (or potion-imbued item, such as a tipped arrow)

-- -@class ItemDetails.ItemGroup The item group this item appears on (The creative tabs this item appears on).
-- -@field id string The namespaced ID for this item group, e.g. minecraft:building_blocks. See the Minecraft wiki for a list of vanilla item group IDs.
-- -@field displayName string The translated display name of the item group. This uses the server's language. This will typically be English on multi-player servers, and your current language on single player.

-- -@class ItemDetails.DamageAndDurability If this item can be damaged (e.g. a pickaxe), then its damage and durability will be available
-- -@field damage number The amount of damage this item has taken.
-- -@field maxDamage number The maximum amount of damage this item has taken.
-- -@field durability? number If this item is damaged (i.e. the durability bar is visible), the percentage left on the durability bar, between 0 and 1 (inclusive).
-- -@field unbreakable? boolean true, if the item is unbreakable

-- -@class ItemDetails.Enchantment The enchantments this item has. This includes both tools and enchanted books.
-- -@field name string The namespaced ID for this enchantment, e.g. minecraft:efficiency. See the Minecraft wiki for a list of vanilla enchantment IDs.
-- -@field displayName string The translated display name for this enchantment.
-- -@field level number The level for this enchantment.

-- -@class ItemDetails.PotionEffect The effects this potion (or potion-imbued item, such as a tipped arrow)
-- -@field name string The namespaced ID for this effect, e.g. minecraft:regeneration. See the Minecraft wiki for a list of vanilla effect IDs.
-- -@field displayName string The translated display name for this potion effect.
-- -@field duration? number The duration this effect will last for (if not instant), in seconds.
-- -@field potency? number The potency of this potion.

-- -@class ItemDetails.MapColour The colour the item's block form will appear on the map, if specified.
-- -@field mapColour? number The colour of the block, as an RGB hex value.
-- -@field mapColor? number The color of the block, as an RGB hex value.
