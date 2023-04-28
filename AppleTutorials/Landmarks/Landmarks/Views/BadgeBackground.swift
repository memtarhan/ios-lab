//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 28/04/2023.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            /*
             You use paths to combine lines, curves, and other drawing primitives to form more complex shapes like the badge’s hexagonal background.
             */
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                /*
                 The move(to:) method moves the drawing cursor within the bounds of a shape as though an imaginary pen or pencil is hovering over the area, waiting to start drawing.
                 */
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * 0.20
                    )
                )

                /*
                 The addLine(to:) method takes a single point and draws it. Successive calls to addLine(to:) begin a line at the previous point and continue to the new point.
                 */
                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )

                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }

    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
