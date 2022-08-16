import Foundation

class Player {
    private var cards : [Card] = []
    
    func setCards(newCards: [Card]) {
        cards.append(contentsOf: newCards)
    }
    
    func showAllCardsDetail() {
        print("======= Player Cards =======");
        
        for card in cards {
            print(card.getTitle());
        }
        
        print("======= ************ =======");
    }
    
    func startGame() {
        cards.removeAll()
    }
    
    func getPlayerScore() -> Int {
        var score = 0;
        
        for card in cards {
            score += card.value;
        }
        
        return score
    }
}
