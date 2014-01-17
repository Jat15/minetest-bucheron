--[[
Bucheron V0.2 par Jat
Licence GPLv2 or later for code

Coupe un tronc si il y a des feuille sur la cime
Coupe les cactus
Coupe papyrus 

--]]
minetest.register_on_dignode(function(p, node, player)
	if node.name=="default:tree" or  node.name=="default:cactus" or node.name=="default:papyrus" or node.name=="madblocks:cactus_winter" then
		local y=p.y
		local f=true
		local name=node.name
		local bois=false
		while f do
			p.y=p.y+1
			node=minetest.env:get_node(p)
			if not(node.name == name) then
				f=false
			end	
		end
		if node.name=="default:leaves" or node.name=="farming_plus:cocoa_leaves" or node.name=="farming_plus:banana_leaves" or node.name=="farming_plus:rubber_leaves" then
			bois=true
		end
		fin=(p.y-y)-1
		if not(player:get_player_name()=="node_breaker") then
			if (bois or not(name=="default:tree")) and player:get_inventory():room_for_item('main', name)  then
				while p.y>y do
					minetest.env:remove_node(p)
					p.y=p.y-1
				end
				player:get_inventory():add_item('main', ''..name..' '..fin..'')
			end
		end
	end
end)