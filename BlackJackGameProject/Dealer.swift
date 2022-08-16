
import Foundation

class Dealer{
    private var cards : [Card]
    private var cardDeck: [Card]
    
    init(cardDeck: [Card]){
        self.cardDeck = cardDeck
        self.cards = []
    }
    
    func setCardForDealer(newCards: [Card]){
        cards.append(contentsOf: newCards)
    }
    
    func startGame(){
        if cardDeck.count < 25 {
            cardDeck = Game.createCardDeck()
        }
        cards.removeAll()
    }
    
    func getCards(count: Int) -> [Card] {
        let selectedCards = Array(cardDeck[0 ..< count])
        print("Selected Card Count \(selectedCards.count)")
        cardDeck.removeSubrange(0 ..< count)
        print("All Card Count \(cardDeck.count)")
        return selectedCards
    }
    
    func checkResult(playerScore: Int) -> GameResult {
        let dealerScore = getDealerScore()
        
        if (playerScore == dealerScore) {
            return GameResult.SCORELESS
        } else if ((playerScore <= 21) && (playerScore > dealerScore)) {
            return GameResult.WIN
        } else if ((playerScore <= 21 && dealerScore > 21)) {
            return GameResult.WIN
        } else {
            return GameResult.LOSE
        }
    }
    
    func isDealerScoreEnoughForFinish() -> Bool {
        if (getDealerScore() < 17 ) {
            return false
        } else {
            return true
        }
    }
    
    func getDealerScore() -> Int {
        var score: Int = 0
        for card in cards {
            score += card.value
        }
        return score
    }
    
    func canUserContinue() -> Bool {
        print("***** The cards is not enough for continue *****")
        return cardDeck.count > 20
    }
    
    func isUserContinueToGame() -> Bool {
        print("Make a choice: For Exit Press N " + "For continue: Press Y:\n")
        let input = readLine()?.lowercased()
        
        switch (input) {
        case "y":
            return true
        case "n":
            return false
        default:
            print("It is unsupported option. .....")
            return isUserContinueToGame()
        }
    }
    
    
    func isUserWantNextCart() -> Bool {
        print("Make a choice: Done D" + " Take a new cart: Press C:\n")
        let input = readLine()?.lowercased()
        
        switch (input) {
        case "c":
            return true
        case "d":
            return false
        default:
            print("It is unsupported option. .....")
            return isUserWantNextCart()
        }
    }
    
    
    func showVisibleCardsOfDealer(showAll: Bool) {
        print("======= Dealer Cards =======")
        for (index, card) in cards.enumerated() {
            if (index == 0 && showAll == false) {
                // Mask first card
                print("#########")
            } else {
                print(card.getTitle())
            }
        }
        print("======= ************ =======")
    }
}




