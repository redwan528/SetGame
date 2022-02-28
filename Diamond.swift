//
//  Diamond.swift
//  SetGame
//  SHINY BRIGHT LIKE A DIAMOND!!!!


import SwiftUI

struct Diamond: Shape {
    private struct DiamondRatios {
        static let widthPercentage: CGFloat = 0.15
        static let offsetPercentage: CGFloat = 0.20
        static let controlHorizontalOffsetPercentage: CGFloat = 0.10
        static let verticalControlPercentage: CGFloat = 0.40
    }
    
    func path(in rect: CGRect) -> Path {
        let topLeft = CGPoint(
            x: rect.width/2.0 - (rect.width * DiamondRatios.widthPercentage/2.0),
            y: rect.height * DiamondRatios.offsetPercentage
        )
        
        let bottomLeft = CGPoint(
            x: rect.width/2.0 - (rect.width * DiamondRatios.widthPercentage/2.0),
            y: rect.height - (rect.height * DiamondRatios.offsetPercentage)
        )

        let controlLeftOne = CGPoint(
            x: (topLeft.x) - (rect.width * DiamondRatios.controlHorizontalOffsetPercentage),
            y: rect.height * (DiamondRatios.verticalControlPercentage)
        )

        let controlLeftTwo = CGPoint(
            x: (topLeft.x) - (rect.width * DiamondRatios.controlHorizontalOffsetPercentage),
            y: rect.height - (rect.height * DiamondRatios.verticalControlPercentage)
        )
      
        
        let controlRightOne = CGPoint(
            x: controlLeftTwo.x + (rect.width * DiamondRatios.widthPercentage),
            y: controlLeftTwo.y
        )
        
        let controlRightTwo = CGPoint(
            x: controlLeftOne.x + (rect.width * DiamondRatios.widthPercentage),
            y: controlLeftOne.y
        )
    
   

        var diamond = Path()

        diamond.move(to: bottomLeft)
        diamond.addCurve(to: topLeft,
                          control1: controlLeftOne,
                          control2: controlLeftTwo)
        
 
 
        
        diamond.move(to: topLeft)
        diamond.addCurve(
            to: bottomLeft,
           control1: controlRightOne,
            control2: controlRightTwo
        )


        return diamond
    }
}

