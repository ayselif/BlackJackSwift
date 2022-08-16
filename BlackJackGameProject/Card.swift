import Foundation

class Card{    
    let name: String
    let type: CardType
    let value: Int

    init(name: String, type: CardType){
        self.name = name
        self.type = type
        self.value = Card.getInitialCardValue(name: name)
    }
    
    static func getInitialCardValue(name: String) -> Int {
        switch (name) {
            case "K", "Q", "J":
                return  10
            case "A":
                return 1
            case "2","3","4","5","6","7","8","9","10":
                return Int(name)!
            default:
                fatalError("Unsupported type.")
        }
    }
    
    func getTitle() -> String{
        return self.name + " \(self.type)"
    }
}



