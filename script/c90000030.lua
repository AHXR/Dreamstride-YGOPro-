--Dreamstride - Nightmirrored Illusion
function c90000030.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),3,2)
	c:EnableReviveLimit()
	
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000030,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetProperty(EFFECT_FLAG2_XMDETACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c90000030.spcost)
	e1:SetTarget(c90000030.sptg)
	e1:SetOperation(c90000030.spop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c90000030.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c90000030.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90000030.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,90000031,0,0x4011,-2,0,1,RACE_FAIRY,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c90000030.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,90000031,0,0x4011,-2,0,1,RACE_FAIRY,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,90000031)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
end
function c90000030.ifilter(c)
	return c:IsFaceup() and c:Code(90000031)
end
function c90000030.indcon(e)
	return Duel.IsExistingMatchingCard(c90000030.ifilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end