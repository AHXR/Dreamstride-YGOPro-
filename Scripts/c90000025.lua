--Dreamstride - Priest
function c90000025.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsType,TYPE_FUSION),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000025,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c90000025.con)
	e1:SetOperation(c90000025.op)
	c:RegisterEffect(e1)
	
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c90000025.reptg)
	e2:SetValue(c90000025.repval)
	c:RegisterEffect(e2)
	
end
----------------------------------------------------------------------
function c90000025.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(90000025)==0 and eg:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		c:RegisterFlagEffect(90000025,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.Hint(HINT_CARD,0,90000025)
			Duel.HintSelection(g)
			if eg:IsContains(tc) then
				e:SetLabelObject(tc)
			else
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
				e1:SetCountLimit(1)
				e1:SetValue(c90000025.valcon)
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
				e:SetLabelObject(nil)
			end
		end
	end
	return true
end
function c90000025.repval(e,c)
	return c==e:GetLabelObject()
end
function c90000025.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end

----------------------------------------------------------------------
function c90000025.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(90000025)==0
end
function c90000025.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVING)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		e1:SetCondition(c90000025.imcon)
		e1:SetOperation(c90000025.imop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC_G)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c90000025.discon)
		e1:SetOperation(c90000025.disop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(90000025,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	end
end
function c90000025.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c90000025.imcon(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_MONSTER) or not Duel.IsChainDisablable(ev) then return false end
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsExists(c90000025.cfilter,1,nil) then return true end
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_RELEASE)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_CONTROL)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DISABLE)
	if ex and tg~=nil and tc+tg:FilterCount(c90000025.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	return false
end
function c90000025.imop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(799183,0)) then
		Duel.NegateEffect(ev)
	end
end

function c90000025.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card) and not c:IsDisabled()
end
function c90000025.disfilter(c)
	local eqg=c:GetEquipGroup():Filter(c90000025.dischk,nil)
	local tgg=Duel.GetMatchingGroup(c90000025.tgg,0,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	return c:IsRace(RACE_FAIRY) and eqg:GetCount()>0
end
function c90000025.dischk(c)
	return not c:IsDisabled()
end
function c90000025.discon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c90000025.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c90000025.disop(e,tp,eg,ep,ev,re,r,rp,c,og)
	Duel.Hint(HINT_CARD,0,90000025)
	local g=Duel.GetMatchingGroup(c90000025.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		local eqg=tc:GetEquipGroup():Filter(c90000025.dischk,nil)
		local tgg=Duel.GetMatchingGroup(c90000025.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tc)
		sg:Merge(eqg)
		sg:Merge(tgg)
		tc=g:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local dg=sg:Select(tp,1,99,nil)
	local dc=dg:GetFirst()
	while dc do
		Duel.NegateRelatedChain(dc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		dc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		dc:RegisterEffect(e2)
		if dc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			dc:RegisterEffect(e3)
		end
		dc=dg:GetNext()
	end
	Duel.BreakEffect()
	return
end
