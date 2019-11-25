-- Author      : Partouf

-- savedvariable
ManaWarning_Settings = {}

-- defaults
bManaWarningActive = true
sManaWarningMsg = 'Need Mana'
iManaWarningTmr = 20
iManaTreshhold = 50.0
bManaDoPotsCheck = true
bManaDoCombatCheck = true

bManaOomStatusAnnounce = true
iOomPercentageTreshhold = 5.0
iOomWarningTmr = 60

bHealthWarningActive = true
sHealthWarningMsg = 'Need Healing'
iHealthWarningTmr = 20
iHealthTreshhold = 50.0
bHealthDoPotsCheck = true
bHealthDoCombatCheck = true

bDisableInPvp = true

sOomMsg = 'OOM!'

sPotionHint = ''

iManaFloodProtection = 99
iCurrentManaFloodCount = 0
bOnlyCheckPotionsInRaid = false

bAnnounceOomToParty = false
bAnnounceOomToInstance = false
bAnnounceOomToRaid = true

sCurrentSpecName = ''

-- timer stuff
ManaWarning_Timers = {}
function ManaWarning_Schedule(t, f)
    local now = GetTime()
    local task = {now + t, f}
    tinsert(ManaWarning_Timers, task)
end

function ManaWarning_CheckTasks()
    local c = #(ManaWarning_Timers)
    local i = 1
    while i <= c do
        local task = ManaWarning_Timers[i]
        if GetTime() > task[1] then
            tremove(ManaWarning_Timers, i)
            c = c - 1
            i = i - 1

            local f = task[2]
            f()
        end
        i = i + 1
    end
end

--

function chkWarningMana_OnClick()
    if (chkWarningMana:GetChecked()) then
        edManaThresh:Show()
        lblManaThresh:Show()
        lblMana:Show()
        lblManaText:Show()
        edManaText:Show()
        lblManaInt:Show()
        edManaInt:Show()
        lblManaIntSeconds:Show()
        edManaFloodProtection:Show()
    else
        edManaThresh:Hide()
        lblManaThresh:Hide()
        lblMana:Hide()
        lblManaText:Hide()
        edManaText:Hide()
        lblManaInt:Hide()
        edManaInt:Hide()
        lblManaIntSeconds:Hide()
        edManaFloodProtection:Hide()
    end
end

function chkWarningHealth_OnClick()
    if (chkWarningHealth:GetChecked()) then
        edHealthThresh:Show()
        lblHealthThresh:Show()
        lblHealth:Show()
        chkWarningHealthCombat:Show()
        chkWarningHealthChecks:Show()
        lblHealthText:Show()
        edHealthText:Show()
        lblHealthInt:Show()
        edHealthInt:Show()
        lblHealthIntSeconds:Show()
    else
        edHealthThresh:Hide()
        lblHealthThresh:Hide()
        lblHealth:Hide()
        chkWarningHealthCombat:Hide()
        chkWarningHealthChecks:Hide()
        lblHealthText:Hide()
        edHealthText:Hide()
        lblHealthInt:Hide()
        edHealthInt:Hide()
        lblHealthIntSeconds:Hide()
    end
end

function chkWarningOom_OnClick()
    if (chkWarningOom:GetChecked()) then
        lblOomThresh:Show()
        edOomThresh:Show()
        lblOomThreshPerc:Show()
        lblOomInt:Show()
        edOomInt:Show()
        lblOomIntSeconds:Show()
        edOomText:Show()
        chkAnnounceOomToParty:Show()
        chkAnnounceOomToInstance:Show()
        chkAnnounceOomToRaid:Show()
    else
        lblOomThresh:Hide()
        edOomThresh:Hide()
        lblOomThreshPerc:Hide()
        lblOomInt:Hide()
        edOomInt:Hide()
        lblOomIntSeconds:Hide()
        edOomText:Hide()
        chkAnnounceOomToParty:Hide()
        chkAnnounceOomToInstance:Hide()
        chkAnnounceOomToRaid:Hide()
    end
end

function btnSave_OnClick()
    ManaWarningSettings_SaveSettingsIntoVars()
    ManaWarningSettings_SaveToSavedVariables()
    ManaWarningSettings:Hide()
end

function btnCancel_OnClick()
    ManaWarningSettings_LoadFromSavedVariables()
    ManaWarningSettings:Hide()
end

function ManaWarningSettings_InitDefaults()
    bManaWarningActive = true
    sManaWarningMsg = 'Need Mana'
    iManaWarningTmr = 20
    iManaTreshhold = 50.0
    bManaDoPotsCheck = true
    bManaDoCombatCheck = true

    bManaOomStatusAnnounce = true
    iOomPercentageTreshhold = 10.0
    iOomWarningTmr = 60

    bHealthWarningActive = true
    sHealthWarningMsg = 'Need Healing'
    iHealthWarningTmr = 20
    iHealthTreshhold = 50.0
    bHealthDoPotsCheck = true
    bHealthDoCombatCheck = true

    iManaFloodProtection = 99
    iCurrentManaFloodCount = 0

    bOnlyCheckPotionsInRaid = false
    bAnnounceOomToParty = false
    bAnnounceOomToInstance = false

    sOomMsg = 'OOM!'

    bAnnounceOomToRaid = true
end

function ManaWarningSettings_LoadFromVars()
    chkWarningMana:SetChecked(bManaWarningActive)
    edManaThresh:SetNumber(iManaTreshhold)
    edManaText:SetText(sManaWarningMsg)
    edManaInt:SetNumber(iManaWarningTmr)
    chkWarningManaCombat:SetChecked(bManaDoCombatCheck)
    chkWarningManaChecks:SetChecked(bManaDoPotsCheck)

    chkWarningHealth:SetChecked(bHealthWarningActive)
    edHealthThresh:SetNumber(iHealthTreshhold)
    edHealthText:SetText(sHealthWarningMsg)
    edHealthInt:SetNumber(iHealthWarningTmr)
    chkWarningHealthCombat:SetChecked(bHealthDoCombatCheck)
    chkWarningHealthChecks:SetChecked(bHealthDoPotsCheck)

    chkWarningOom:SetChecked(bManaOomStatusAnnounce)
    edOomThresh:SetNumber(iOomPercentageTreshhold)
    edOomInt:SetNumber(iOomWarningTmr)

    edOomText:SetText(sOomMsg)

    edManaFloodProtection:SetNumber(iManaFloodProtection)
    chkOnlyCheckPotionsInRaid:SetChecked(bOnlyCheckPotionsInRaid)

    chkAnnounceOomToParty:SetChecked(bAnnounceOomToParty)
    chkAnnounceOomToInstance:SetChecked(bAnnounceOomToInstance)
    chkAnnounceOomToRaid:SetChecked(bAnnounceOomToRaid)
end

function ManaWarningSettings_SaveSettingsIntoVars()
    bManaWarningActive = chkWarningMana:GetChecked()
    iManaTreshhold = edManaThresh:GetNumber()
    sManaWarningMsg = edManaText:GetText()
    iManaWarningTmr = edManaInt:GetNumber()
    bManaDoCombatCheck = chkWarningManaCombat:GetChecked()
    bManaDoPotsCheck = chkWarningManaChecks:GetChecked()

    bHealthWarningActive = chkWarningHealth:GetChecked()
    iHealthTreshhold = edHealthThresh:GetNumber()
    sHealthWarningMsg = edHealthText:GetText()
    iHealthWarningTmr = edHealthInt:GetNumber()
    bHealthDoCombatCheck = chkWarningHealthCombat:GetChecked()
    bHealthDoPotsCheck = chkWarningHealthChecks:GetChecked()

    bManaOomStatusAnnounce = chkWarningOom:GetChecked()
    iOomPercentageTreshhold = edOomThresh:GetNumber()
    iOomWarningTmr = edOomInt:GetNumber()

    sOomMsg = edOomText:GetText()

    iManaFloodProtection = edManaFloodProtection:GetNumber()
    bOnlyCheckPotionsInRaid = chkOnlyCheckPotionsInRaid:GetChecked()

    bAnnounceOomToParty = chkAnnounceOomToParty:GetChecked()
    bAnnounceOomToInstance = chkAnnounceOomToInstance:GetChecked()
    bAnnounceOomToRaid = chkAnnounceOomToRaid:GetChecked()
end

function ManaWarningSettings_Refresh()
    chkWarningManaText:SetText('Mana warning')
    chkWarningHealthText:SetText('Health warning')
    chkWarningOomText:SetText('OOM warning')
    chkWarningManaCombatText:SetText('Only when in combat')
    chkWarningManaChecksText:SetText('Check cooldowns')
    chkWarningHealthCombatText:SetText('Only when in combat')
    chkWarningHealthChecksText:SetText('Check cooldowns')
    chkOnlyCheckPotionsInRaidText:SetText('Only check potions in raid')
    chkAnnounceOomToPartyText:SetText('Announce OOM to party')
    chkAnnounceOomToInstanceText:SetText('Announce OOM to instance')
    chkAnnounceOomToRaidText:SetText('Announce OOM to raid')

    ManaWarningSettings_LoadFromVars()

    chkWarningMana_OnClick()
    chkWarningHealth_OnClick()
    chkWarningOom_OnClick()
end

function ManaWarningSettings_LoadFromSavedVariables()
    if (#(ManaWarning_Settings) >= 15) then
        bManaWarningActive = ManaWarning_Settings[1]
        iManaTreshhold = ManaWarning_Settings[2]
        sManaWarningMsg = ManaWarning_Settings[3]
        iManaWarningTmr = ManaWarning_Settings[4]
        bManaDoCombatCheck = ManaWarning_Settings[5]
        bManaDoPotsCheck = ManaWarning_Settings[6]
        bHealthWarningActive = ManaWarning_Settings[7]
        iHealthTreshhold = ManaWarning_Settings[8]
        sHealthWarningMsg = ManaWarning_Settings[9]
        iHealthWarningTmr = ManaWarning_Settings[10]
        bHealthDoCombatCheck = ManaWarning_Settings[11]
        bHealthDoPotsCheck = ManaWarning_Settings[12]
        bManaOomStatusAnnounce = ManaWarning_Settings[13]
        iOomPercentageTreshhold = ManaWarning_Settings[14]
        iOomWarningTmr = ManaWarning_Settings[15]

        -- dirty hack for old situation with mp instead of percentages
        if iManaTreshhold > 100.0 then
            iManaTreshhold = 50.0
        end
        if iHealthTreshhold > 100.0 then
            iHealthTreshhold = 50.0
        end

        if #(ManaWarning_Settings) >= 16 then
            sOomMsg = ManaWarning_Settings[16]
        end

        bDisableInPvp = ManaWarning_Settings[17]

        if #(ManaWarning_Settings) >= 18 then
            iManaFloodProtection = ManaWarning_Settings[18]
        end

        bOnlyCheckPotionsInRaid = ManaWarning_Settings[19]
        bAnnounceOomToParty = ManaWarning_Settings[20]
        bAnnounceOomToRaid = ManaWarning_Settings[21]

        if ManaWarning_Settings[22] == -1 then
            -- old, default to false
        else
            bAnnounceOomToInstance = ManaWarning_Settings[22]
        end
    else
        ManaWarningSettings_InitDefaults()
        ManaWarningSettings_SaveToSavedVariables()
    end
end

function ManaWarningSettings_SaveToSavedVariables()
    ManaWarning_Settings = {}
    ManaWarning_Settings[1] = bManaWarningActive
    ManaWarning_Settings[2] = iManaTreshhold
    ManaWarning_Settings[3] = sManaWarningMsg
    ManaWarning_Settings[4] = iManaWarningTmr
    ManaWarning_Settings[5] = bManaDoCombatCheck
    ManaWarning_Settings[6] = bManaDoPotsCheck
    ManaWarning_Settings[7] = bHealthWarningActive
    ManaWarning_Settings[8] = iHealthTreshhold
    ManaWarning_Settings[9] = sHealthWarningMsg
    ManaWarning_Settings[10] = iHealthWarningTmr
    ManaWarning_Settings[11] = bHealthDoCombatCheck
    ManaWarning_Settings[12] = bHealthDoPotsCheck
    ManaWarning_Settings[13] = bManaOomStatusAnnounce
    ManaWarning_Settings[14] = iOomPercentageTreshhold
    ManaWarning_Settings[15] = iOomWarningTmr
    ManaWarning_Settings[16] = sOomMsg
    ManaWarning_Settings[17] = bDisableInPvp
    ManaWarning_Settings[18] = iManaFloodProtection
    ManaWarning_Settings[19] = bOnlyCheckPotionsInRaid
    ManaWarning_Settings[20] = bAnnounceOomToParty
    ManaWarning_Settings[21] = bAnnounceOomToRaid
    ManaWarning_Settings[22] = bAnnounceOomToInstance
end

function btnRestoreDefaults_OnClick()
    ManaWarningSettings_InitDefaults()
    ManaWarningSettings_LoadFromVars()

    chkWarningMana_OnClick()
    chkWarningHealth_OnClick()
    chkWarningOom_OnClick()
end

-------------------------------------------------

-- consts
CONST_VARSLOADED = 'VARIABLES_LOADED'
CONST_POWERUPDATE = 'UNIT_POWER_UPDATE'
CONST_HEALTHUPDATE = 'UNIT_HEALTH'
CONST_PLAYER = 'player'
CONST_SPEC_CHANGE = 'ACTIVE_TALENT_GROUP_CHANGED'

-- vars
bReady = false
bManaWarningGiven = false
bHealthWarningGiven = false
bManaOOMWarningGiven = false

bDebug = false

-- Mage shared cooldown gems
MANA_RESTORING_STUFF_A = {
    [8007] = 'Mana Citrine',
    [5513] = 'Mana Jade',
    [5514] = 'Mana Agate'
}

-- Shared cooldown mana pots
MANA_RESTORING_STUFF_B = {
    [13444] = 'Major Mana Potion',
    [13443] = 'Superior Mana Potion',
    [6149] = 'Greater Mana Potion',
    [3827] = 'Mana Potion',
    [3385] = 'Lesser Mana Potion',
    [2455] = 'Minor Mana Potion'
}

-- health stuff; no cooldown, just disapears when used
HEALTH_RESTORING_STUFF_A = {
    [9421] = 'Major Healthstone',
    [5510] = 'Greater Healthstone',
    [5509] = 'Healthstone',
    [5511] = 'Lesser Healthstone',
    [5512] = 'Minor Healthstone'
}

-- Shared cooldown healing pots
HEALTH_RESTORING_STUFF_B = {
    [13446] = 'Major Healing Potion',
    [3928] = 'Superior Healing Potion',
    [1710] = 'Greater Healing Potion',
    [929] = 'Healing Potion',
    [858] = 'Lesser Healing Potion',
    [118] = 'Minor Healing Potion'
}

-- OnLoad function
function ManaWarning_OnLoad(obj)
    ManaWarningSettings:Hide()

    obj:RegisterEvent(CONST_VARSLOADED)

    obj:RegisterEvent(CONST_POWERUPDATE)
    obj:RegisterEvent(CONST_HEALTHUPDATE)

    obj.name = 'ManaWarning'

    SlashCmdList['MANAWARNING_SLASHCMD'] = ManaWarning_SlashFunc
    SLASH_MANAWARNING_SLASHCMD1 = '/manawarning'
end

function ManaWarning_SlashFunc()
    ManaWarningSettings:Show()
    ManaWarningSettings_Refresh();
end

function ManaWarning_PlayerIsInPvp()
    if UnitIsPVP(CONST_PLAYER) then
        return true
    end

    return false
end

-- OnEvent
function ManaWarning_OnEvent(obj, event, ...)
    ManaWarning_CheckTasks()

    if (event == CONST_VARSLOADED) then
        ManaWarningSettings_LoadFromSavedVariables()

        bReady = true
    elseif (event == CONST_POWERUPDATE) then
        bDoCheck = true
        if bDisableInPvp then
            bDoCheck = not ManaWarning_PlayerIsInPvp()
        end

        if bDoCheck then
            local unitId, resource = ...
            if (bManaWarningActive or bManaOomStatusAnnounce) then
                if (resource == 'MANA') then
                    -- apparently you get updates for everyone in your party/raid, so check if we get a "player" update
                    if (unitId == CONST_PLAYER) then
                        ManaWarning_PlayerManaUpdate()
                    end
                end
            end
        end
    elseif (event == CONST_HEALTHUPDATE) then
        bDoCheck = true
        if bDisableInPvp then
            bDoCheck = not ManaWarning_PlayerIsInPvp()
        end

        if bDoCheck then
            local unitId = ...
            if (bHealthWarningActive) then
                if (unitId == CONST_PLAYER) then
                    ManaWarning_PlayerHealthUpdate()
                end
            end
        end
    elseif (event == CONST_SPEC_CHANGE) then
        ManaWarning_PlayerSpecChange()
    end
end

function getLowestCDInArrayOfItems(iHighestCD, array)
    iLowestRemainingTime = iHighestCD

    for itemId, sName in pairs(array) do
        ic = GetItemCount(itemId)

        if (ic > 0) then
            pot_start, pot_dur, pot_en = GetItemCooldown(itemId)
            remaining_time = 0

            if (pot_start > 0) then
                current_time = GetTime()
                remaining_time = floor(pot_dur - (current_time - pot_start))
            end

            if (remaining_time < iLowestRemainingTime) then
                iLowestRemainingTime = remaining_time
            end
        end

        if (iLowestRemainingTime == 0) then
            sPotionHint = sName

            break
        end
    end

    return iLowestRemainingTime
end

function getSpellCD(sName)
    current_time = GetTime()

    usable, nomana = IsUsableSpell(sName)
    if (usable) then
        spell_start, spell_dur, spell_en = GetSpellCooldown(sName)
        if (spell_start) then
            if spell_dur < 1.5 then -- ignore gcd
                return 0
            else
                if (spell_start > 0) then
                    remaining_time = floor(spell_dur - (current_time - spell_start))

                    return remaining_time
                end
            end
        end

        return 0
    end

    return 600
end

function HasManaTideTotemOut()
    for i = 1, 40 do
        local buff = UnitBuff(CONST_PLAYER, i)
        if buff then
            if (buff == 'Mana Tide Totem') then
                return true
            end
        end
    end

    return false
end

-- Are all Mana restoring items on cooldown?
function ManaWarning_TimeManaOnCooldown()
    iLowestRemainingTime = 600 -- 10 minutes

    iLowestRemainingTime = getLowestCDInArrayOfItems(iLowestRemainingTime, MANA_RESTORING_STUFF_A)
    if (iLowestRemainingTime == 0) then
        return 0
    end

    -- special spells
    locClass, enClass = UnitClass(CONST_PLAYER)

    if (enClass == 'DRUID') then
        iSpCd = getSpellCD('Innervate')

        if (iSpCd < iLowestRemainingTime) then
            iLowestRemainingTime = iSpCd
        end
        if (iSpCd == 0) then
            sPotionHint = 'Innervate'
            return 0
        end
    elseif (enClass == 'MAGE') then
        iSpCd = getSpellCD('Evocation')

        if (iSpCd < iLowestRemainingTime) then
            iLowestRemainingTime = iSpCd
        end
        if (iSpCd == 0) then
            sPotionHint = 'Evocation'
            return 0
        end
    elseif (enClass == 'PRIEST') then
        iSpCd = getSpellCD('Shadowfiend')

        if (iSpCd < iLowestRemainingTime) then
            iLowestRemainingTime = iSpCd
        end
        if (iSpCd == 0) then
            sPotionHint = 'Shadowfiend'
            return 0
        end
    elseif (enClass == 'SHAMAN') then
        iSpCd = getSpellCD('Mana Tide Totem')

        if (iSpCd == 0) and not HasManaTideTotemOut() then
            sPotionHint = 'Mana Tide Totem'
            return 0
        end
    end

    bCheckPots = false
    if bOnlyCheckPotionsInRaid then
        bCheckPots = UnitInRaid(CONST_PLAYER)
    else
        bCheckPots = true
    end

    if bCheckPots then
        iLowestRemainingTime = getLowestCDInArrayOfItems(iLowestRemainingTime, MANA_RESTORING_STUFF_B)
        if (iLowestRemainingTime == 0) then
            return 0
        end
    end

    return iLowestRemainingTime
end

-- Are all Health restoring items on cooldown?
function ManaWarning_TimeHealthOnCooldown()
    iLowestRemainingTime = 600 -- 10 minutes

    iLowestRemainingTime = getLowestCDInArrayOfItems(iLowestRemainingTime, HEALTH_RESTORING_STUFF_A)
    if (iLowestRemainingTime == 0) then
        return 0
    end

    bCheckPots = false
    if bOnlyCheckPotionsInRaid then
        bCheckPots = UnitInRaid(CONST_PLAYER)
    else
        bCheckPots = true
    end

    if bCheckPots then
        iLowestRemainingTime = getLowestCDInArrayOfItems(iLowestRemainingTime, HEALTH_RESTORING_STUFF_B)
        if (iLowestRemainingTime == 0) then
            return 0
        end
    end

    return iLowestRemainingTime
end

function ManaWarning_MessagePartyRaid(sMsg)
    local sMsg2 = sMsg
    --RaidNotice_AddMessage(RaidBossEmoteFrame, sMsg2, ChatTypeInfo["RAID_WARNING"]);

    local done = false

    if (UnitInRaid(CONST_PLAYER)) then
        if (bAnnounceOomToRaid) and not ManaWarning_PlayerIsInPvp() then
            SendChatMessage(sMsg, 'RAID', nil, '')
            done = true
        else
            if DEFAULT_CHAT_FRAME then
                DEFAULT_CHAT_FRAME:AddMessage(sMsg2, 1.0, 0.0, 0.0)
                done = true
            end
        end
    elseif (bAnnounceOomToInstance) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        SendChatMessage(sMsg, 'INSTANCE_CHAT', nil, '')
        done = true
    end

    if not done and bAnnounceOomToParty and IsInGroup() then
        SendChatMessage(sMsg, 'PARTY', nil, '')
        done = true
    end

    if not done then
        if DEFAULT_CHAT_FRAME then
            DEFAULT_CHAT_FRAME:AddMessage(sMsg2, 1.0, 0.0, 0.0)
        end
    end
end

function ManaWarning_MessageSelf(sMsg)
    local sMsg2 = sMsg
    --RaidNotice_AddMessage(RaidBossEmoteFrame, sMsg2, ChatTypeInfo["RAID_WARNING"]);

    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(sMsg2, 1.0, 0.0, 0.0)
    end
end

-- PlayerManaUpdate
function ManaWarning_PlayerManaUpdate()
    -- if mana user atm
    if (UnitPowerType(CONST_PLAYER) == 0) then
        maxmana = UnitPowerMax(CONST_PLAYER)
        currentmana = UnitPower(CONST_PLAYER)

        bMayGiveWarning = true
        
        if (UnitIsDead(CONST_PLAYER)) then
            bMayGiveWarning = false
        elseif (bManaDoCombatCheck) then
            -- don't warn if we're not in combat
            if (UnitAffectingCombat(CONST_PLAYER) == nil) then
                bMayGiveWarning = false
            end
        end

        iLowestRemainingTime = 0
        if (bManaDoPotsCheck) then
            sPotionHint = ''
            iLowestRemainingTime = ManaWarning_TimeManaOnCooldown()
        end

        if (bMayGiveWarning and bManaOomStatusAnnounce and not bManaOOMWarningGiven) then
            oom_tresh = maxmana / 100.0 * iOomPercentageTreshhold
            if (currentmana < oom_tresh) then
                bManaOOMWarningGiven = true

                if (bManaDoPotsCheck) then
                    ManaWarning_MessagePartyRaid(sOomMsg .. " (CD's " .. iLowestRemainingTime .. 's)')
                else
                    ManaWarning_MessagePartyRaid(sOomMsg)
                end
                ManaWarning_Schedule(iOomWarningTmr, ManaWarning_ResetManaOOMWarningGiven)
            end
        end

        if (bManaWarningActive and bMayGiveWarning and not bManaWarningGiven) then
            mana_tresh = maxmana / 100.0 * iManaTreshhold
            if (currentmana < mana_tresh) then
                bManaWarningGiven = true

                if (iLowestRemainingTime == 0) then
                    iLowestRemainingTime = iManaWarningTmr
                end

                ManaWarning_Schedule(iLowestRemainingTime, ManaWarning_ResetManaWarningGiven)

                if iCurrentManaFloodCount < iManaFloodProtection then
                    iCurrentManaFloodCount = iCurrentManaFloodCount + 1

                    if (bManaDoPotsCheck) then
                        if not (sPotionHint == '') then
                            ManaWarning_MessageSelf(sManaWarningMsg .. ' (Try using ' .. sPotionHint .. ')')
                        end
                    else
                        ManaWarning_MessageSelf(sManaWarningMsg)
                    end
                end
            else
                -- class specific stuff once no more below treshhold
                --locClass, enClass = UnitClass( CONST_PLAYER );
                --if ( enClass == "HUNTER" ) then
                --end
                -- reset flood protection once you're above the treshhold
                iCurrentManaFloodCount = 0
            end
        end
    end
end

-- PlayerHealthUpdate
function ManaWarning_PlayerHealthUpdate()
    currenthp = UnitHealth(CONST_PLAYER)
    maxhp = UnitHealthMax(CONST_PLAYER)

    bMayGiveWarning = true
    
    if (UnitIsDead(CONST_PLAYER)) then
        bMayGiveWarning = false
    elseif (bHealthDoCombatCheck) then
        -- don't warn if we're not in combat
        if (UnitAffectingCombat(CONST_PLAYER) == nil) then
            bMayGiveWarning = false
        end
    end

    if (bMayGiveWarning and not bHealthWarningGiven) then
        health_tresh = maxhp / 100.0 * iHealthTreshhold
        if (currenthp < health_tresh) then
            bHealthWarningGiven = true

            iLowestRemainingTime = 0
            if (bHealthDoPotsCheck) then
                sPotionHint = ''
                iLowestRemainingTime = ManaWarning_TimeHealthOnCooldown()
            end

            if (iLowestRemainingTime == 0) then
                iLowestRemainingTime = iHealthWarningTmr
            end

            ManaWarning_Schedule(iLowestRemainingTime, ManaWarning_ResetHealthWarningGiven)

            if (bHealthDoPotsCheck) then
                if not (sPotionHint == '') then
                    ManaWarning_MessageSelf(sHealthWarningMsg .. ' (Try using ' .. sPotionHint .. ')')
                end
            else
                ManaWarning_MessageSelf(sHealthWarningMsg)
            end
        end
    end
end

-- Resets a boolean, so the ManaWarning will again show on the screen if we're still without mana
function ManaWarning_ResetManaWarningGiven()
    bManaWarningGiven = false
end

function ManaWarning_ResetHealthWarningGiven()
    bHealthWarningGiven = false
end

-- Resets a boolean, so the OOM-message will again show
function ManaWarning_ResetManaOOMWarningGiven()
    bManaOOMWarningGiven = false
end
