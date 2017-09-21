--Dreamstride - Connection Inflicter
function c90000011.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,90000002,90000001,true,true)

	-- Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000011,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c90000011.sptg)
	e1:SetOperation(c90000011.spop)
	c:RegisterEffect(e1)
	
	--draw
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(90000011,1))
	e8:SetCategory(CATEGORY_DRAW)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_BE_MATERIAL)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCondition(c90000011.drcon)
	e8:SetTarget(c90000011.drtg)
	e8:SetOperation(c90000011.drop)
	c:RegisterEffect(e8)
	
	--syn limit
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetValue(c90000011.synlimit)
	c:RegisterEffect(e10)
end
---------------------------------------------------------------------------
function c90000011.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_FAIRY)
end
---------------------------------------------------------------------------
function c90000011.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c90000011.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000011.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
---------------------------------------------------------------------------
function c90000011.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c90000011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000011.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c90000011.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000011.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
