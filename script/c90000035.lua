--Dreamstride - Crippling Connection
function c90000035.initial_effect(c)

	--fusion material
    c:EnableReviveLimit()
    aux.AddFusionProcCode2(c,90000013,90000011,true,true)
	
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000035,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c90000035.target)
	e1:SetOperation(c90000035.operation)
	c:RegisterEffect(e1)
	
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e2)
	
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000035,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c90000035.condition)
	e3:SetTarget(c90000035.ctarget)
	e3:SetOperation(c90000035.coperation)
	c:RegisterEffect(e3)
end
---------------------------------------------------------------------------
function c90000035.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c90000035.ctarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rc=e:GetHandler():GetReasonCard()
	rc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
end
function c90000035.coperation(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	if rc:IsRelateToEffect(e) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
---------------------------------------------------------------------------
function c90000035.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetFlagEffect(90000013)+1
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return c:GetAttack()>=ct*300
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	c:RegisterFlagEffect(90000013,RESET_CHAIN,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c90000035.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup()
		and c:GetAttack()>=300 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-300)
		c:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetValue(-500)
		tc:RegisterEffect(e3)
	end
end
