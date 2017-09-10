--Journey to Dreamstride
function c90000009.initial_effect(c)
	c:SetUniqueOnField(1,0,90000009)
	
	-- Add FAIRY
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,90000009+EFFECT_COUNT_CODE_OATH)
	e2:SetOperation(c90000009.activate)
	c:RegisterEffect(e2)
	
	-- Draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000009,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_BOTH_SIDE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c90000009.condition)
	e3:SetTarget(c90000009.target)
	e3:SetOperation(c90000009.operation)
	c:RegisterEffect(e3)
end
----------------------------------------------------------
function c90000009.ssfilter(c,tp)
	return c:IsControler(tp) and ( c:GetSummonType()==SUMMON_TYPE_SYNCHRO or c:GetSummonType()==SUMMON_TYPE_FUSION )
end
function c90000009.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c90000009.ssfilter,1,nil,tp) and ep==tp and Duel.GetCurrentChain()==0
end
function c90000009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000009.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

----------------------------------------------------------
function c90000009.activate(e,tp,eg,ep,ev,re,r,rp)
	-- Spell cards
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c90000009.elimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)

	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c90000009.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(90000009,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end

function c90000009.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_FAIRY) and c:IsAbleToHand()
end
----------------------------------------------------------
--[[
function c90000009.actlimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c90000009.elimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--]]
function c90000009.elimit(e,te,tp)
	return te:GetHandler():IsType(TYPE_SPELL)
end