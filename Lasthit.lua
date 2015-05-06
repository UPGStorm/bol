local player = GetMyHero()
local tick = 0
local delay = 400
local version = 1.0
  
function OnLoad()
  PrintChat("<font color='#7FFF00'> Last Hit loaded! </font>")
  LHConfig = scriptConfig("Last Hit", "LastHit")
  LHConfig:addParam("lasthit", "Last Hit for me", SCRIPT_PARAM_ONKEYDOWN, false, 32)
  LHConfig:permaShow("lasthit")
  enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
 
 if tonumber(GetWebResult("raw.github.com", "/UPGStorm/versions/master/LastHit.rev")) > version then
 PrintChat("Updating")
    DownloadFile("https://raw.githubusercontent.com/Jo7j/BoL/master/myVision.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, 
    function()
        PrintChat("Update finished Please reload (F9).")
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