﻿local checkVC = {}
local xml = xmlLoadFile("meta.xml")
local DownloadList = {}
local ind = 0
local Completed = false


repeat
	local chld = xmlFindChild(xml, "file", ind)
	if(chld) then
		local str = xmlNodeGetAttribute(chld, "src")   
		table.insert(DownloadList, str)
		ind = ind + 1
	else
		Completed = true
		outputServerLog("Resource Vice City is ready to use")
	end
until Completed; 



function CreateVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2)
	local theVehicle = createVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2)
	setElementDimension(theVehicle, 2)
	return theVehicle
end




function Go_LC(thePlayer)
	setCameraTarget(thePlayer, thePlayer)
	setElementPosition(thePlayer, -772.8, -1108.2, 18)
	setElementDimension(thePlayer, 2)
	setElementInterior(thePlayer, 0)
	setElementFrozen(thePlayer, false)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if(theVehicle) then
		setElementPosition(theVehicle, -772.8, -1108.2, 20)
		setElementDimension(theVehicle, 2)
		setElementInterior(theVehicle, 0)
	end
	outputChatBox("Welcome to Vice City!", thePlayer)
	checkVC[thePlayer] = "vc"
end
addEvent("Go_LC", true)
addEventHandler("Go_LC", root, Go_LC)


function CheckEnd(thePlayer)
	checkVC[thePlayer] = "vc"
	setElementFrozen(thePlayer, true)
	setCameraMatrix(thePlayer, 6564.8213-8100, -9173.364+8100, 58.48705, 6564.8213-8000, -9173.364+8000, 8.48705) -- 1288.5, 1189, 75.7, 788.5, 689, 25.7)
	
	setElementDimension(thePlayer, 2)
	setElementInterior(thePlayer, 0)
	if(theVehicle) then
		setElementDimension(theVehicle, 2)
		setElementInterior(theVehicle, 0)
	end
end
addEvent("CheckEnd", true)
addEventHandler("CheckEnd", root, CheckEnd)



function vc(thePlayer, command, h)
	if(not checkVC[thePlayer]) then
		triggerClientEvent(thePlayer, "CheckFiles", thePlayer, DownloadList)
		checkVC[thePlayer] = "check"
	else
		if(checkVC[thePlayer] == "vc") then
			Go_LC(thePlayer)
		end
	end
end
addCommandHandler("vc", vc)
