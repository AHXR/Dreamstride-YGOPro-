--Dreamstride - Conscious
function c90000000.initial_effect(c)
      	local poly=Effect.CreateEffect(c)
       	poly:SetDescription(aux.Stringid(90000000,0))
       	poly:SetType(EFFECT_TYPE_IGNITION)
       	poly:SetCode(EVENT_TO_GRAVE)
       	poly:SetRange(LOCATION_HAND)
       	poly:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
       	poly:SetTarget(c90000000.target)
       	poly:SetCost(c90000000.cost)
       	poly:SetOperation(c90000000.operation)
       	c:RegisterEffect(poly)
		
		local search=Effect.CreateEffect(c)
       	search:SetDescription(aux.Stringid(90000000,1))
       	search:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
       	search:SetCode(EVENT_SPSUMMON_SUCCESS)
      	search:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
      	search:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
       	search:SetTarget(c90000000.starget)
       	search:SetOperation(c90000000.soperation)
       	c:RegisterEffect(search)
		
		--spsummon
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(90000000,2))
		e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e3:SetCode(EVENT_ATTACK_ANNOUNCE)
		e3:SetRange(LOCATION_GRAVE)
		e3:SetCondition(c90000000.spcon)
		e3:SetTarget(c90000000.sptg)
		e3:SetOperation(c90000000.spop)
		c:RegisterEffect(e3)

end
---------------------------------------------------
function c90000000.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c90000000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90000000.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
---------------------------------------------------
function c90000000.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler( )
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end

function c90000000.filter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end

function c90000000.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000000.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c90000000.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g = Duel.SelectMatchingCard( tp, c90000000.filter, tp, LOCATION_DECK, 0, 1, 1, nil )
	if g:GetCount( )>0 then
		Duel.SendtoHand( g, nil, REASON_EFFECT )
		Duel.ConfirmCards( 1-tp, g )
	end
end
---------------------------------------------------
function c90000000.sfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToHand()
end
function c90000000.starget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000000.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90000000.soperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000000.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

