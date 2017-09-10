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
       	search:SetRange(LOCATION_HAND)
      	search:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
      	search:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
       	search:SetTarget(c90000000.starget)
       	search:SetOperation(c90000000.soperation)
       	c:RegisterEffect(search)

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
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000000.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

