import Foundation

class Player {
    private var cards : [Card] = []
    private let fileHelper: FileOperationHelper
    
    init(helper: FileOperationHelper) {
        self.fileHelper = helper
    }
    
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
    
    func getNewBet () -> Int {
        while (true) {
            print("What is your bet?")
            let input = readLine()?.trimmingCharacters(in: .whitespaces)
            if let bet = Int(input ?? "") {
                if checkPlayerBetAndPoint(currentBet: bet)  {
                    return bet
                } else {
                    print("Your balance not enough.")
                }
            }
        }
    }
    
    func checkPlayerBetAndPoint(currentBet: Int) -> Bool {
        let currentPoint = getPlayerPoint()
        let sub = currentPoint - currentBet
        return sub >= 0 && currentBet <= 10 && currentBet > 0
    }
    
    func setPlayerPoint(bet: Int) {
        fileHelper.writePointToFile(point: bet)
    }
    
    func getPlayerPoint() ->Int {
        return fileHelper.readPointFromFile()
    }
}
