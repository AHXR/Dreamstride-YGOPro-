--Dreamstride X - Sacred Royalty
function c90000033.initial_effect(c)

	--fusion material
    c:EnableReviveLimit()
    aux.AddFusionProcCode2(c,90000025,90000018,true,true)
	
	--cannot special summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
	
	--aclimit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetOperation(c90000033.regop)
    c:RegisterEffect(e2)
	
	--multi attack
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_EXTRA_ATTACK)
    e3:SetValue(1)
    c:RegisterEffect(e3)
	
	--actlimit2
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetCode(EFFECT_CANNOT_ACTIVATE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetTargetRange(0,1)
    e4:SetValue(c90000033.aclimit)
    e4:SetCondition(c90000033.actcon)
    c:RegisterEffect(e4)
	
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e5)
end
-----------------------------------------------------------
function c90000033.aclimit(e,re,tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c90000033.actcon(e)
    return Duel.GetAttacker()==e:GetHandler()
end
-----------------------------------------------------------
function c90000033.regop(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(0,1)
    e1:SetValue(c90000033.aclimit)
    e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
    Duel.RegisterEffect(e1,tp)
end 
function c90000033.aclimit(e,re,tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end