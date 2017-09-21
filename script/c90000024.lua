--Dreamstride - Inner Loathe
function c90000024.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,90000023,90000007,true,true)

	--no battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e1)
	
	--register
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetOperation(c90000024.regop)
	c:RegisterEffect(e2)
	
	--draw
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(90000024,1))
	e8:SetCategory(CATEGORY_DRAW)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_BE_MATERIAL)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCondition(c90000024.drcon)
	e8:SetTarget(c90000024.drtg)
	e8:SetOperation(c90000024.drop)
	c:RegisterEffect(e8)
	
	--syn limit
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetValue(c90000024.synlimit)
	c:RegisterEffect(e10)
end
---------------------------------------------------------------------------
function c90000024.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_FAIRY)
end
---------------------------------------------------------------------------
function c90000024.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c90000024.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000024.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
---------------------------------------------------------------------------

function c90000024.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousPosition(POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(90000024,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c90000024.sptg)
		e1:SetOperation(c90000024.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c90000024.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90000024.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
