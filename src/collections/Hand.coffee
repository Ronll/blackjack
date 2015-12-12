class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    
    scoreNum = @minScore()

    if @scores()[1] == 21 then alert("BlackJack, You Won!")

    if scoreNum > 21
      alert("#{if @isDealer then "You Won!, Dealer Busted" else "You Lost!, Busted"}")
    else if scoreNum == 21
      alert("#{if @isDealer then "You Lost, Dealer Got 21" else "You Won!, you got 21!"}")

    @last()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
  ,
  stand: ->
    if @scores()[1] == 21 then alert("BlackJack, You Won!")
    else @trigger 'playerStand', this
  ,  
  dealerPlay: (playerHand) ->
    @first().flip();
    if @scores()[1] == 21 then alert("Dealer Got BlackJack, You Lost!")

    checkHandStatus = =>
      if @minScore() > 21
        alert("#{if @isDealer then "You Won!, Dealer Busted" else "You Lost!, Busted"}" )
      else if @minScore() == 21
        alert("#{if @isDealer then "You Lost, Dealer Got 21" else "You Won!, you got 21!"}")

    checkHandStatus();

    dealerScore = @minScore()
    while dealerScore <= 16
      @add(@deck.pop())
      checkHandStatus()
      dealerScore = @minScore()

    playerScore = playerHand.minScore()
    dealerScore = @minScore()

    if playerScore == dealerScore
      alert('Push')
    else if playerScore > dealerScore
      alert('You Won!')
    else if playerScore < dealerScore
      alert('You Lost!')
      













