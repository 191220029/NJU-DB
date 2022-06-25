-- 姓名：傅小龙
-- 学号：191220029
-- 提交前请确保本次实验独立完成，若有参考请注明并致谢。

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1
select count(*) speciesCount
from Species
where description like '%this%';
-- END Q1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2
select Player.username, SUM(Phonemon.power)totalPhonemonPower
from Player, Phonemon
where (username = 'Cook' OR username = 'Hughes') and Player.id = Phonemon.player
group by username;
-- END Q2

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3
select title, count(Player.id) numberOfPlayers
from Player, Team
where Player.team = Team.id
group by Team.id
order by count(Player.id) desc;
-- END Q3

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q4
select Species.id idSpecies, Species.title
from Species, Type
where Type.title = 'grass' AND (type1 = Type.id OR type2 = Type.id);
-- END Q4

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q5
select id idPlayer, username
from Player
where Player.id not in
(
	select Player.id
	from Player, Item, Purchase
	where Player.id = Purchase.player and Purchase.item = Item.id and Item.type = 'F'
);
-- END Q5

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q6
select Player.level, sum(Purchase.quantity * Item.price) totalAmountSpentByAllPlayersAtLevel
from Player, Purchase, Item
where Player.id = Purchase.player and Item.id = Purchase.item
group by level
order by sum(Purchase.quantity * Item.price) desc;
-- END Q6

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q7
select purchase.item, item.title, count(purchase.item) numTimesPurchased
from purchase, item
where purchase.item = item.id
group by purchase.item
having numTimesPurchased >= all(
	select count(purchase.item)
	from purchase
	group by purchase.item
);          
-- END Q7

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q8
select Player.id, Player.username, count(distinct Item.id) numberDistinctFoodItemsPurchased
from Player, Purchase, Item
where Player.id = Purchase.player and Purchase.item = Item.id and Item.type = 'F'
group by Player.id
having numberDistinctFoodItemsPurchased = (select count(*) from food);
-- END Q8

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q9
select count(*) numberOfPhonemonPairs, round(sqrt(power((t1.latitude - t2.latitude), 2) + power((t1.longitude - t2.longitude), 2)) * 100, 3) distanceX
from Phonemon t1, Phonemon t2
where t1.id < t2.id
group by distanceX
having distanceX <= all(
	select round(sqrt(power((t1.latitude - t2.latitude), 2) + power((t1.longitude - t2.longitude), 2)) * 100, 3) distanceX
	from Phonemon t1, Phonemon t2
	where t1.id < t2.id
);
-- END Q9

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q10
select t.username, t.typeTitle
from
(
	select player.username username, type.title typeTitle, type.id
	from player, phonemon, species, type
	where player.id = phonemon.player and phonemon.species = species.id and (species.type1 = type.id or species.type2 = type.id)
	group by player.id, type.id
	having count(distinct species.id) = (
		select count(*) from Species where Species.type1 = type.id or Species.type2 = type.id
	)
)as t
-- END Q10