





import SwiftUI

struct Oval: Shape {
    
    //Below is the scalable image canvas box of the drawing itself, the percentages r the percent it will cover the card with.
    private struct OvalRatios {
        static let widthPercentage: CGFloat = 0.25
        static let offsetPercentage: CGFloat = 0.50
        static let controlHorizontalOffsetPercentage: CGFloat = 0.10
        static let verticalControlPercentage: CGFloat = 0.40
    }
    func path(in rect: CGRect) -> Path {
      
        let topLeft = CGPoint(
            x: rect.width/2.0 - (rect.width * OvalRatios.widthPercentage/2.0),
            y: rect.height * OvalRatios.offsetPercentage
        )
        
        let bottomLeft = CGPoint(
            x: rect.width/2.0 - (rect.width * OvalRatios.widthPercentage/2.0),
            y: rect.height - (rect.height * OvalRatios.offsetPercentage)
        )

        
     
        
        let topRight = CGPoint(
            x: rect.width/2.0 + (rect.width * OvalRatios.widthPercentage/2.0),
            y: rect.height * OvalRatios.offsetPercentage
        )
        let bottomRight = CGPoint(
            x: rect.width/2.0 + (rect.width * OvalRatios.widthPercentage/2.0),
            y: rect.height - (rect.height * OvalRatios.offsetPercentage)
        )
        
        
        
        let topCenter = CGPoint(
            x: (topLeft.x + topRight.x)/2.0,
            y: topLeft.y
        )
        
        let bottomCenter = CGPoint(
            x: (bottomLeft.x + bottomRight.x)/2.0,
            y: bottomLeft.y
        )
        
        let arcRadius = CGFloat(
            (topRight.x - topLeft.x)/2.0
        )
 
        
        
        
        var oval = Path()
        
        //top arc curve
        oval.addArc(
            center: topCenter,
            radius: arcRadius,
            startAngle: Angle.radians(Double.pi),
            endAngle: Angle.radians(0.0),
            clockwise: false
        )
        
       
        //bottom arc curve
        oval.addArc(
            center: bottomCenter,
            radius: arcRadius,
            startAngle: Angle.radians(Double.pi),
            endAngle: Angle.radians(0.0),
            clockwise: true
        )
        
       
   
       
     
        return oval
    }
    
    
    
}
