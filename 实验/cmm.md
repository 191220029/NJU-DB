7

select Purchase.item, Item.title, count(Item.id) numTimesPurchased
from Purchase, Item
where Purchase.item = Item.id
group by Item.id
having numTimesPurchased >= all(select count(Item.id)
								from Purchase, Item
								where Purchase.item = Item.id
								group by Item.id)

8.

select Player.id, Player.username, count(distinct Item.id) numberDistinctFoodItemsPurchased
from Player, Purchase, Item
where Player.id = Purchase.player and Purchase.item = Item.id and Item.type = 'F'
group by Player.id
having numberDistinctFoodItemsPurchased = all(select count(*) from Item where Item.type = 'F')