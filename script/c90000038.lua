--Dreamstride X - Nightmare Dragon
function c90000038.initial_effect(c)
	--fusion material
    c:EnableReviveLimit()
    aux.AddFusionProcCodeFun(c,90000021, c90000038.ffilter,1,false,false)

	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c90000038.efr)
	c:RegisterEffect(e1)
	
	--increase atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetTarget(c90000038.atktg)
	e2:SetOperation(c90000038.atkop)
	c:RegisterEffect(e2)
	
	--summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c90000038.sumsuc)
	c:RegisterEffect(e4)
	
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e5)
	
	--send spells&traps to grave
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetTarget(c90000038.target)
	e6:SetOperation(c90000038.activate)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)
	
end
-------------------------------------------------------------------------------
function c90000038.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY) and c:IsType(TYPE_FUSION)
end
function c90000038.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000038.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
end
function c90000038.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c90000038.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
		local atk=g:GetSum(Card.GetAttack)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
		end
	end
end
-------------------------------------------------------------------------------
function c90000038.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c90000038.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c90000038.filter,tp,0,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c90000038.filter,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c90000038.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c90000038.filter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end

-------------------------------------------------------------------------------
function c90000038.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
-------------------------------------------------------------------------------
function c90000038.ffilter(c)
	return c:IsType(TYPE_FUSION) and c:IsRace(RACE_FAIRY)
end
-------------------------------------------------------------------------------
function c90000038.efr(e,re)
	return re:GetHandler():GetControler()~=e:GetHandler():GetControler()
end