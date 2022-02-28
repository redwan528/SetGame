//
//  SetGame.swift
//  Set
//


//MODEL for the game rules, this game model talks to the deck. Goal is to connect game model to the deck and ViewModel

import Foundation

struct SetGame /*:ObservableObject*/ {
    
     private(set) var currentDeck = SetCardDeck() //this var allows access to SetCardDeck file
    
   private(set) var cards = [SetCard]() // these are the cards in play
    //private(set) var cards: Array<SetCard>

    var score = 0
    
    mutating func selectCard(/* parm to identify card */_ card: SetCard) {
        if let chosenIndex = /*index(of: card)*/ cards.firstIndex(where: {
             //filter func, goes thru array to match card id
           $0.id == card.id
        }) {
            
            cards[chosenIndex].isSelected.toggle()
            
            
          
            //print("\(cards[chosenIndex])")
        }
    }
    
    //private(set) var threeSelectedCardsArray = [SetCard]()
    
    /*
    func selectedCards(){
        for _ in 0...2 {
            if selectCard(cards){
                
            }
            //threeSelectedCardsArray.append(selectCard(cards))
        }
    }
    */
    
    mutating func scoreCount(){
        if setLogic(){
            score+=1
        }
    }

    mutating func set12Cards(){ //puts 12 cards from deck into cards array
        for _ in 0...11 {
            cards.append(currentDeck.remove())   //removes cards from deck to put on display
        }
    }

    init(){
        set12Cards()
       
    } 
    
    mutating func checkForEmptyDeck(){
        if currentDeck.isEmpty() {
           //print("No more cards are left in your deck")
            
            return
        }
    }
    
   mutating func add3Cards(){
        
   
    print(currentDeck.count())
    
    
        for _ in 0...2 {
           // self.cards.append(currentDeck.remove())   //removes cards from deck to put on display
            if currentDeck.isEmpty() {
               //print("No more cards are left in your deck")
                
                return
            }
           
            cards.append(currentDeck.remove())
        }
    }
    
    func deckCounter() -> Int {
        
         return currentDeck.count()
    }
    
    func deckAlert() -> Int{
        if currentDeck.count() == 0 {
            return currentDeck.count()
        }
        return 0
    }
    
   mutating func newGameButton(){
       
        //remove all current cards on screen
    cards.removeAll()
      
        //Now reset deck with 81 cards again
        currentDeck = SetCardDeck()
        
        set12Cards() //draw 12 new cards from new deck on display on screen
       
    }
  
    
    
    func setLogic() -> Bool {
        let shapeCount = (cards[0].shape == cards[1].shape && cards[1].shape == cards[2].shape)
        
        let colorMatch = (cards[0].color == cards[1].color && cards[1].color == cards[2].color)
        
        let shadeMatch = (cards[0].shade == cards[1].shade && cards[1].shade == cards[2].shade)
        
        let drawingCount =  (cards[0].count == cards[1].count && cards[1].count == cards[2].count)
        
        
        if shapeCount && colorMatch && shadeMatch && drawingCount  {
            return true
        }
        
        if !(shapeCount && colorMatch && shadeMatch && drawingCount) {
            return true
        }
        else {
            return false
        }
      
    }

}


