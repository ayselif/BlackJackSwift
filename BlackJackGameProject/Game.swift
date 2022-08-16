import Foundation

class Game{
    private let player: Player = Player()
    private let dealer: Dealer = Dealer(cardDeck: Game.createCardDeck())
    
    func startGame(){
        print("Welcome BlackJack Table")
        newGameSession()
    }
    
    private func newGameSession() {
        print("**************** New Game Started ******************")
        dealer.startGame()
        player.startGame()
        
        dealer.setCardForDealer(newCards: dealer.getCards(count: 2))
        player.setCards(newCards: dealer.getCards(count: 2))
        
        // Show Cards Detail
        dealer.showVisibleCardsOfDealer(showAll: false)
        player.showAllCardsDetail()
        
        while (dealer.isUserWantNextCart() && dealer.canUserContinue()) {
            // Set new cards
            dealer.setCardForDealer(newCards: dealer.getCards(count: 1))
            player.setCards(newCards: dealer.getCards(count: 1))
            
            // Show Cards Detail
            dealer.showVisibleCardsOfDealer(showAll: false)
            player.showAllCardsDetail()
        }
        
        checkGameStatus()
        
        if (dealer.isUserContinueToGame()) {
            newGameSession()
        }
    }
    
    
    private func checkGameStatus() {
        while(dealer.isDealerScoreEnoughForFinish() == false) {
            dealer.setCardForDealer(newCards: dealer.getCards(count: 1))
        }
        
        let gameResult: GameResult  = dealer.checkResult(playerScore: player.getPlayerScore())
        print("**************** Done ******************")
        switch (gameResult) {
        case .LOSE:
            print("User LOSE")
            break
        case .SCORELESS:
            print("User SCORELESS")
            break
        case .WIN:
            print("User WIN")
            break
        }
        
        // Show Cards Detail
        dealer.showVisibleCardsOfDealer(showAll: true)
        player.showAllCardsDetail()
    }
    
    static func createCardDeck() -> [Card] {
        var cardDeck: [Card] = []
        
        for name in Card.cardNames {
            cardDeck.append(Card(name: name, type: .HEARTS))
            cardDeck.append(Card(name: name, type: .DIAMONDS))
            cardDeck.append(Card(name: name, type: .CLUBS))
            cardDeck.append(Card(name: name, type: .SPADES))
        }
        
        return cardDeck.shuffled()
    }
}
