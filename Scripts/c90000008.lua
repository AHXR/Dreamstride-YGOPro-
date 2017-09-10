--Dreamstride - Witch
function c90000008.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,90000008)
	e1:SetCondition(c90000008.spcon)
	c:RegisterEffect(e1)
	
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetCondition(c90000008.subcon)
	c:RegisterEffect(e2)
end
---------------------------------
function c90000008.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY) and not c:IsCode(90000008)
end
function c90000008.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000008.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
------------------------------------
function c90000008.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE)
end