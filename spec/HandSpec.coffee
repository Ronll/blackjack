assert = chai.assert

describe 'Hand', ->
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck();
    playerHand = new Hand [deck.pop(), deck.pop()], deck
    dealerHand = new Hand [deck.pop().flip(), deck.pop()], deck, true

  describe 'scores', ->
    deck = new Deck();
    it 'should tell you when you got BlackJack', ->
      ace = new Card
        rank: 1
        suit: 0
      ten = new Card
        rank: 10
        suit: 0
      playerHand = new Hand [ace, ten], deck
      assert(playerHand.scores()[1] == 21)