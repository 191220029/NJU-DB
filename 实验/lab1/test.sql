select *
from Player, Purchase, Item, Food
where Player.id = Purchase.player and Purchase.item = Item.id and Item.id = Food.id
