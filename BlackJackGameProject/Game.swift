import Foundation

class Game{
    private let player: Player
    private let dealer: Dealer = Dealer(cardDeck: Game.createCardDeck())
    private let fileHelper: FileOperationHelper = FileOperationHelper() // 352
    private var bet: Int = 0
    
    init() {
        player = Player(helper: fileHelper)
    }
    
    func startGame(){
        fileHelper.createFileIfNeeded()
        print("Welcome BlackJack Table")
        newGameSession()
    }
    
    private func newGameSession() {
        checkStartBalance()
        print("Total Balance \(player.getPlayerPoint())")
        print("**************** New Game Started ******************")
        dealer.startGame()
        player.startGame()
        
        bet = player.getNewBet()
        
        dealer.setCardForDealer(newCards: dealer.getCards(count: 2))
        player.setCards(newCards: dealer.getCards(count: 2))
        
        // Show Cards Detail
        dealer.showVisibleCardsOfDealer(showAll: false)
        player.showAllCardsDetail()
        
        while (dealer.isUserWantNextCard() && dealer.canUserContinue()) {
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
            player.setPlayerPoint(bet: -bet)
        case .SCORELESS:
            print("User SCORELESS")
        case .WIN:
            print("User WIN")
            player.setPlayerPoint(bet: bet)
        }
        
        // Show Cards Detail
        dealer.showVisibleCardsOfDealer(showAll: true)
        player.showAllCardsDetail()
    }
    
    func checkStartBalance() {
        if player.getPlayerPoint() <= 0 {
            print("You are so poor");
            exit(0)
        }
    }
    

    static func createCardDeck() -> [Card] {
        let cardNames = ["A", "Q", "J", "K", "2","3","4","5","6","7","8","9","10"]
        var cardDeck: [Card] = []
        
        for name in cardNames {
            cardDeck.append(Card(name: name, type: .HEARTS))
            cardDeck.append(Card(name: name, type: .DIAMONDS))
            cardDeck.append(Card(name: name, type: .CLUBS))
            cardDeck.append(Card(name: name, type: .SPADES))
        }
        
        return cardDeck.shuffled()
    }
}
