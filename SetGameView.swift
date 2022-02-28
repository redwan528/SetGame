

//
//  ContentView.swift
//  
//

//

import SwiftUI

struct SetGameView: View {
    
   //@StateObject var setGame = SetGame()
    /*@StateObject*/ @ObservedObject var viewModel = ViewModel()
    
    @State var noCardsInDeckAlert: Bool = true
    
    var body: some View {
   
        VStack {
            gameBody
            Spacer()
            showDeckCount
            Spacer()
            //scoreCount
            Spacer()
            HStack {
                newGame
                Spacer()
                peek
                Spacer()
                //plusThree
                if viewModel.model.currentDeck.isEmpty(){
                    plusThree.disabled(true)
           // Text("\(viewModel.deckAlert())")
                        .alert(isPresented: $noCardsInDeckAlert, content: {
                        Alert(title: Text("error"),
                              message: Text("no cards left in deck")//,
                              //dismissButton: Text("ok")
                              /*
                              primaryButton: .destructive(Text("ok"), action: {
                              //  _ = plusThree.disabled(false)
                              }),
                              secondaryButton: .cancel()
                              */
                              )
                    })
                } else{
                    plusThree
                }
            }
            .padding(.horizontal)
        }
    }

     var gameBody: some View {
         AspectVGrid(items: viewModel.model.cards, aspectRatio: 3/2) { setCard in
            SetCardView(setCard)
                .onTapGesture {
                    viewModel.choose(card: setCard)
                }
            
        }
   
    }
    
    var showDeckCount: some View {
        
        return Text("Deck: \(viewModel.deckCounter()) cards left")
        
    }
    
    //var scoreCount: some View {
        //viewModel.scoreCount()
       // return Text("Score:  \(viewModel.scoreCount())")
   // }
   
    var newGame: some View {
        Button {
          
            viewModel.newGame()
            
        } label: {
            VStack {
                Image(systemName: "arrowtriangle.right.circle")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Text("New Game")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    
   
    var peek: some View {
        Button {
            // action for peek
        } label: {
            VStack {
                Image(systemName: "eye")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .foregroundColor(.red)

                Text("peek")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    var plusThree: some View {
        Button {
    
            
            viewModel.addThreeCards()
               // noCardsInDeckAlert.toggle()
    
        }
     
        label: {
            VStack {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .foregroundColor(.red)

                Text("Add 3 cards")
                    .font(.caption)
                    .foregroundColor(.red)

            }
            
            
        }

    }
 

}

struct SetCardView: View {
    private let setCard: SetCard
    private let lineColor: Color
    
    init(_ setCard: SetCard) {
        self.setCard = setCard
        if setCard.isSelected {
            lineColor = Color.black
        } else if setCard.isMatched {
            lineColor = Color.green
        } else if setCard.isMisMatched {
            lineColor = Color.red
        } else {
            lineColor = Color.gray
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let roundedRectangle = RoundedRectangle(cornerRadius: 10)
                roundedRectangle.fill()
                    .foregroundColor(Color.white)
                roundedRectangle.stroke(lineWidth: 3.0)
                    .foregroundColor(lineColor)
                if setCard.shade == .outlined {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .stroke(colorForPath(for: setCard))
                } else if setCard.shade == .filled {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .fill(colorForFill(for: setCard))
                } else if setCard.shade == .striped {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .stroke(colorForPath(for: setCard))
                        .clipShape(getPath(for: setCard, in: geometry.frame(in: .local)))
                }
            }
        }
        .padding()
    }

    private func colorForFill(for setCard: SetCard) -> Color {
        switch setCard.shade {
        case .outlined:
            return .clear
        case .striped:
            return .clear
        case .filled:
            return colorForPath(for: setCard)
        }
    }

    private func getPath(for setCard: SetCard, in rect: CGRect) -> Path {
        var path: Path
        switch setCard.shape {
        case SetCard.Shapes.diamond:
            path = Diamond().path(in: rect)
        case SetCard.Shapes.oval:
            path = Oval().path(in: rect) 
        case SetCard.Shapes.squiggle:
            path = Sqiggle().path(in: rect)
        }
        
        path = replicatePath(path, for: setCard, in: rect)
        
        if (setCard.shade == .striped) {
            path.addPath(getStripedPath(in: rect))
        }
        
        return path
    }

    private func getStripedPath(in rect: CGRect) -> Path {
        var stripedPath = Path()
        
        let dy: CGFloat = rect.height / 10.0
        var start = CGPoint(x: 0.0, y: dy)
        var end = CGPoint(x: rect.width, y: dy)
        while start.y < rect.height {
            stripedPath.move(to: start)
            stripedPath.addLine(to: end)
            start.y += dy
            end.y += dy
        }
        
        return stripedPath
    }
    
    
    
    private func colorForPath(for setCard: SetCard) -> Color {
        switch setCard.color {
        case SetCard.Colors.green:
            return .green
        case SetCard.Colors.purple:
            return .purple
        case SetCard.Colors.red:
            return .red
        }
    }

    private func replicatePath(_ path: Path, for setCard: SetCard, in rect: CGRect) -> Path {
        
        var leftTwoPathTranslation: CGPoint {
            return CGPoint(
                x: rect.width * -0.15,
                y: 0.0
            )
        }
        
        var rightTwoPathTranslation: CGPoint {
            return CGPoint(
                x: rect.width * 0.15,
                y: 0.0
            )
        }
        
        var leftThreePathTranslation: CGPoint {
            return CGPoint(
                x: rect.width * -0.25,
                y: 0.0
            )
        }
        
        var rightThreePathTranslation: CGPoint {
            return CGPoint(
                x: rect.width * 0.25,
                y: 0.0
            )
        }

        var replicatedPath = Path()
        
        if (setCard.count == 1) {
            replicatedPath = path
        } else if (setCard.count == 2) {
            let leftTransform = CGAffineTransform(
                translationX: leftTwoPathTranslation.x,
                y: leftTwoPathTranslation.y)
            
            let rightTransform = CGAffineTransform(
                translationX: rightTwoPathTranslation.x,
                y: rightTwoPathTranslation.y)
            
            replicatedPath.addPath(path, transform: leftTransform)
            replicatedPath.addPath(path, transform: rightTransform)
        } else {
            let leftTransform = CGAffineTransform(translationX: leftThreePathTranslation.x,
                                                  y: leftThreePathTranslation.y)
            let rightTransform = CGAffineTransform(translationX: rightThreePathTranslation.x,
                                                   y: rightThreePathTranslation.y)
            replicatedPath.addPath(path)
            replicatedPath.addPath(path, transform: leftTransform)
            replicatedPath.addPath(path, transform: rightTransform)

        }
      
        return replicatedPath
    }
    
    
    struct SetGameView_Previews: PreviewProvider {
        static var previews: some View {
            let something = ViewModel()
            
            SetGameView(viewModel: something)
           
        }
        
    }
    
    
}

