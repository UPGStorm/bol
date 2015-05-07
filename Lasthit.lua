local player = GetMyHero()
local tick = 0
local delay = 400
local version = 1.0
  
function OnLoad()
  PrintChat("<font color='#7FFF00'> Last Hit loaded! </font>")
  LHConfig = scriptConfig("Last Hit v1.0", "LastHit")
  LHConfig:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, 32)
  LHConfig:permaShow("lasthit")
  enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
	if tonumber(GetWebResult("raw.github.com", "/UPGStorm/versions/master/LastHit.rev")) > version then
		PrintChat("Updating Last Hit")
		DownloadFile("https://raw.githubusercontent.com/UPGStorm/bol/master/Lasthit.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, 
	function()
        PrintChat("Last Hit updated! Please press F9 to reload.")
     end
    )
  end 
end

function OnTick()
  enemyMinions:update()
  if LHConfig.lasthit then
    for index, minion in pairs(enemyMinions.objects) do
      if GetDistance(minion, myHero) <= (myHero.range + 75) and GetTickCount() > tick + delay then
        local dmg = getDmg("AD", minion, myHero)
        if dmg > minion.health then
          myHero:Attack(minion)
          tick = GetTickCount()
        end
      end
    end
  end
end
