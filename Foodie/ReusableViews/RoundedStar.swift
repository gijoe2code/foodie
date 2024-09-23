//
//  RoundedStar.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI

/// Displays a star-shaped Shape View
/// Based on: https://stackoverflow.com/questions/63650216/how-to-create-a-swiftui-roundedstar-shape
struct RoundedStar: Shape {
    var cornerRadius: CGFloat = 2

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc

        // start angle at -18 degrees so that it points up
        var cangle = -18.0

        for i in 1 ... 5 {
            // compute center point of tip arc
            let cc = CGPoint(x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)), y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians)))

            // compute tangent point along tip arc
            let p = CGPoint(x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - 72).radians)), y: cc.y + rc * CGFloat(sin(Angle(degrees: (cangle - 72)).radians)))

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }

            // add 144 degree arc to draw the corner
            path.addArc(center: cc, radius: rc, startAngle: Angle(degrees: cangle - 72), endAngle: Angle(degrees: cangle + 72), clockwise: false)

            // Move 144 degrees to the next point in the star
            cangle += 144
        }

        return path
    }

}
