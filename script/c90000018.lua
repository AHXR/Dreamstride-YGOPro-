--Dreamstride - Priestess
function c90000018.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsType,TYPE_FUSION),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000018,0))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c90000018.discon)
	e3:SetTarget(c90000018.distg)
	e3:SetOperation(c90000018.disop)
	c:RegisterEffect(e3)
	--atk change
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c90000018.atkop)
	c:RegisterEffect(e4)
end
----------------------------------------------------------------------------
function c90000018.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsActiveType(TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c90000018.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000018.disop(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:GetHandler():IsFacedown() or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c90000018.filter(c)
	return c:IsRace(RACE_FAIRY) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsType(TYPE_SYNCHRO) 
end
function c90000018.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	local atk=Duel.GetMatchingGroupCount(c90000018.filter,tp,LOCATION_GRAVE,0,nil)*500
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
