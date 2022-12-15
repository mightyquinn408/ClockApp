//
//  ContentView.swift
//  ClockApp
//
//  Created by Mike Quinn on 12/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let clock = ClockAngles(for: timeline.date)
                
                let drawRect = CGRect(origin: .zero, size: size)
                let radius = min(size.width, size.height) / 2
                
                let borderThickness = radius / 25
                let innerBlackRingSize = radius / 6
                let centerSize = radius / 40
                
                let hourHandLength = radius / 2.5
                let minuteHandLength = radius / 1.5
                
                let seconHandLength = radius * 1.1
                let secondHandWidth = radius / 25
                
                context.stroke(Circle()
                    .inset(by: borderThickness / 2)
                    .path(in: drawRect),
                               with: .color(.primary),
                               lineWidth: borderThickness
                )
                context.translateBy(x: drawRect.midX, y: drawRect.midY)
                
                drawHand(in: context, radius: radius, length: minuteHandLength, angle: clock.minute)
                drawHand(in: context, radius: radius, length: hourHandLength, angle: clock.hour)
                drawHours(in: context, radius: radius)
            }
        }
    }
    
    func drawHand(in context: GraphicsContext, radius: Double, length: Double, angle: Angle) {
        let width = radius / 30

        let stalk = Rectangle().rotation(angle, anchor: .top).path(in: CGRect(x: -width / 2, y: 0, width: width, height: length))
        context.fill(stalk, with: .color(.primary))
        
        let hand = Capsule().offset(x: 0, y: radius / 5).rotation(angle, anchor: .top).path(in: CGRect(x: -width, y: 0, width: width * 2, height: length))
        context.fill(hand, with: .color(.primary))
    }
    
    func drawHours(in context: GraphicsContext, radius: Double) {
        let textSpace = CGSize(width: 200, height: 200)
        let textSize = radius / 4
        let textOffset = radius * 0.75
        
        for i in 1...12 {
            var contextCopy = context
            let text = Text(String(i)).font(.system(size: textSize)).bold()
            let resolvedText = contextCopy.resolve(text)

            let textSize = resolvedText.measure(in: textSpace)
            contextCopy.translateBy(x: -textSize.width / 2, y: -textSize.height / 2)
            let point = CGPoint(x: 0, y: -textOffset).applying(CGAffineTransform(rotationAngle: Double(i) * .pi / 6))
            contextCopy.draw(resolvedText, in: CGRect(origin: point, size: textSpace))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
