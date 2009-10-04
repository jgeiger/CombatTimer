CombatTimer = LibStub("AceAddon-3.0"):NewAddon("CombatTimer", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

combatSeconds = 0

function CombatTimer:OnInitialize()
  -- Code that you want to run when the addon is first loaded goes here.
  CombatTimer:Print("CombatTimer Loaded.")
end

function CombatTimer:OnEnable()
  -- Called when the addon is enabled
  CombatTimer:RegisterEvent("PLAYER_REGEN_DISABLED")
  CombatTimer:RegisterEvent("PLAYER_REGEN_ENABLED")
  CombatTimer:RegisterEvent("PLAYER_DEAD")
end

function CombatTimer:OnDisable()
  -- Called when the addon is disabled
  self:CancelAllTimers()
end

function CombatTimer:PLAYER_REGEN_DISABLED()
  -- process the event
  combatSeconds = 0
  self.mainTimer = self:ScheduleRepeatingTimer("InCombat", 1)
  timerWindow:Show();
end

function CombatTimer:PLAYER_REGEN_ENABLED()
  -- process the event
  self:CancelTimer(self.mainTimer)
--  timerWindow:Hide();
  print("Combat took "..convertSeconds(combatSeconds))
end

function CombatTimer:PLAYER_DEAD()
  -- process the event
  self:CancelTimer(self.mainTimer)
--  timerWindow:Hide();
  print("Combat took "..convertSeconds(combatSeconds))
end

function CombatTimer:InCombat()
  combatSeconds = combatSeconds + 1
  --update the frame here
  message = convertSeconds(combatSeconds)
  timerWindow_Text:SetText(message)
--  UIErrorsFrame:AddMessage(message, 1.0, 1.0, 1.0, 5.0)
end

function CombatTimer_DragStart()
  timerWindow:StartMoving();
  timerWindow.isMoving = true;
end

function CombatTimer_DragStop()
  timerWindow:StopMovingOrSizing();
  timerWindow.isMoving = false;
end

function convertSeconds(seconds)
	local sec = seconds %60;
	local min = (seconds-sec)/60;
    
  local smin = tostring(min);
  local ssec = tostring(sec);
    
	if (strlen(smin) == 1) then
		smin = "0"..smin;
	end
	if (strlen(ssec) == 1) then
		ssec = "0"..ssec;
	end
  
	ttxt = smin..":"..ssec;
  return ttxt;
end
