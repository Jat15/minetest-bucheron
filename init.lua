--[[
Bucheron V0.3 par Jat
Licence GPLv2 or later for code
 
--]]
local zone = 3

local function dedans(liste,entrée)
	for c=1,table.getn(liste) do
		if liste[c].x==entrée.x and liste[c].y==entrée.y and liste[c].z==entrée.z then
			return true
		end
	end
	return false
end


local function collerliste(listepos,tree,listesortie)
	if tree~=nil then
		if listesortie == nil then
			liste = listepos
		else
			liste = listesortie
		end
		for c=1,table.getn(tree) do
			if not(dedans(liste,tree[c]))then
				table.insert(liste,tree[c])
			end
		end
	end
	return liste
end

minetest.register_on_dignode(function(p, node, player)
	if minetest.get_node_group(node.name, "tree")~=0 then
		local postree = {p}
		local posleaves = {}
		local compteur=1
		repeat
			local s
			if compteur>10 then
				s = minetest.find_nodes_in_area({x=postree[compteur].x-zone,y=postree[compteur].y-zone,z=postree[compteur].z-zone},{x=postree[compteur].x+zone,y=postree[compteur].y+zone,z=postree[compteur].z+zone},node.name)
			else
				s = minetest.find_nodes_in_area({x=postree[compteur].x-zone,y=postree[compteur].y,z=postree[compteur].z-zone},{x=postree[compteur].x+zone,y=postree[compteur].y+zone,z=postree[compteur].z+zone},node.name)	
			end
			postree = collerliste(postree,s,nil)
			
			local s = minetest.find_nodes_in_area({x=postree[compteur].x-zone,y=postree[compteur].y-zone,z=postree[compteur].z-zone},{x=postree[compteur].x+zone,y=postree[compteur].y+zone,z=postree[compteur].z+zone},"group:leaves")
			posleaves = collerliste(postree,s,posleaves)
			
			if table.getn(posleaves)<50 and compteur>100 then
				break
			end
			compteur=compteur+1
		until compteur >= table.getn(postree)

		if table.getn(posleaves)>table.getn(postree)*2 then
			for i=1,table.getn(postree) do
				minetest.remove_node(postree[i])
			end
			
			for i=1,table.getn(posleaves) do
				minetest.remove_node(posleaves[i])
			end
		end
		
	end
end)

