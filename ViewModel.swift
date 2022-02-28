//
//  ViewModel.swift
//  SetGame
//

//


import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published private(set) var deckModel = SetCardDeck()
    @Published private(set) var model = SetGame() //@Publsiehd lets the view know that when these funcs are calling the mutating model funcs like from SetGame, the mutating funcs from model are changing
    //private (set) var setCardDeck = SetCardDeck()
   // @Published var cards = [SetCard]() // these are the cards in play
    
    func scoreCount(){
        model.scoreCount()  
    }
    func choose(card: SetCard) {
        model.selectCard(card)
    }
    
    func addThreeCards() {
 
      
             model.add3Cards()
 
    }
    
    func deck(){
        
        model.checkForEmptyDeck()
     
    }

    //also shuffles the cards and displays 12 cards on screen
 
    func newGame() {
       
        model.newGameButton()

    }
    
    func cardsInDeckCounter () {
        print("if u read this then this func works")
      //  _ = deckModel.count()
        print(deckModel.count())
    }
    
    func deckCounter() -> Int{
        //print(model.currentDeck.count())
        return model.deckCounter()
    }
    
    func deckAlert() -> Int {
        return model.deckAlert()
    }
    
    func shuffleDeck(){
        shuffleDeck()
    }
    
    var accessCardsinPlay: [SetCard]{
        model.cards
    }
    

    
}

