//
//  RatingRowView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI

/// Displays Restaurant or Review content with a star on the left and optionally a header above
struct RatingRowView<Content: View>: View {

    var heading: String?
    var rating: StarRating?
    var isAverage: Bool
    var content: Content

    public init(heading: String? = nil,
                rating: StarRating?,
                isAverage: Bool = false,
                @ViewBuilder content: () -> Content) {
        self.heading = heading
        self.rating = rating
        self.isAverage = isAverage
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let heading = heading {
                Text(heading)
                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 15)))
            }
            HStack {
                ZStack {
                    RoundedStar()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .foregroundStyle(.onSurface)
                    if let rating = rating {
                        VStack(spacing: 0) {
                            Text("\(rating, specifier: "%.1f")")
                            if isAverage {
                                Text("avg")
                            }
                        }
                        .font(.system(size: 14))
                        .foregroundStyle(.starText)
                        .bold()
                    }
                }

                content
                Spacer()
            }.padding(.vertical, 5)
        }
    }
}

#Preview {
    RatingRowView(rating: 4.0) {
        Text("Joe's Kansas City BBQ")
    }
}
