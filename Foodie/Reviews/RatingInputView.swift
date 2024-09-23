//
//  RatingInputView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI

/// Displays a horizontal group of 5 star-shaped buttons to select a rating from 1-5
struct RatingInputView: View {

    @Binding var rating: StarRating.StarInput

    var body: some View {
        HStack {
            Button {
                rating = .one
            } label: {
                Image(systemName: "star.fill")
            }
            Button {
                rating = .two
            } label: {
                Image(systemName: rating.rawValue >= 2 ? "star.fill" : "star")
            }
            Button {
                rating = .three
            } label: {
                Image(systemName: rating.rawValue >= 3 ? "star.fill" : "star")
            }
            Button {
                rating = .four
            } label: {
                Image(systemName: rating.rawValue >= 4 ? "star.fill" : "star")
            }
            Button {
                rating = .five
            } label: {
                Image(systemName: rating.rawValue == 5 ? "star.fill" : "star")
            }
        }.foregroundStyle(.primaryTheme)
    }
}

#Preview {
    @State var starRating = StarRating.StarInput.five
    return RatingInputView(rating: $starRating)
}
