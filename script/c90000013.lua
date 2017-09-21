--Dreamstride - Crippling Voices
function c90000013.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,90000007,90000001,true,true)
	
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000013,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c90000013.target)
	e1:SetOperation(c90000013.operation)
	c:RegisterEffect(e1)
	
	--draw
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(90000013,1))
	e8:SetCategory(CATEGORY_DRAW)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_BE_MATERIAL)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCondition(c90000013.drcon)
	e8:SetTarget(c90000013.drtg)
	e8:SetOperation(c90000013.drop)
	c:RegisterEffect(e8)
	
	--syn limit
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetValue(c90000013.synlimit)
	c:RegisterEffect(e10)
end
---------------------------------------------------------------------------
function c90000013.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_FAIRY)
end
---------------------------------------------------------------------------
function c90000013.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c90000013.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000013.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
---------------------------------------------------------------------------
function c90000013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetFlagEffect(90000013)+1
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return c:GetAttack()>=ct*500
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	c:RegisterFlagEffect(90000013,RESET_CHAIN,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c90000013.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup()
		and c:GetAttack()>=500 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		c:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetValue(-500)
		tc:RegisterEffect(e3)
	end
end
