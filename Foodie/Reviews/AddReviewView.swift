//
//  AddReviewView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI
import SwiftData

/// View for adding a Review for a given Restaurant
struct AddReviewView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    var restaurant: Restaurant
    @State private var rating: StarRating.StarInput = .five
    @State private var date = Date()
    @State private var notes = ""

    var body: some View {
        VStack(spacing: 16) {
            Text(restaurant.name)

            RatingInputView(rating: $rating)

            DatePicker("Date", selection: $date, displayedComponents: .date)

            TextEditor(text: $notes)

            Button {
                saveReview(rating: rating, date: date, notes: notes)
            } label: {
                Text("Save").frame(maxWidth: .infinity)
                    .padding(.vertical)
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top)

            Button {
                dismiss()
            } label: {
                Text("Cancel").frame(maxWidth: .infinity)
                    .padding(.vertical)
            }.buttonStyle(SecondaryButtonStyle())
        }
        .navigationTitle("Add Review")
        .padding()
        .background(.surface)
    }
    
    /// Saves a new Review to SwiftData
    /// - Parameters:
    ///   - rating: the 1-5 star rating
    ///   - date: the selected date for the review
    ///   - notes: text notes associated with the review
    private func saveReview(rating: StarRating.StarInput,
                            date: Date,
                            notes: String) {
        let newReview = Review(restaurant: restaurant, starRating: rating, date: date, notes: notes)
        modelContext.insert(newReview)
        restaurant.reviews.append(newReview)

        // determine and set the restaurant's mostRecentReviewDate
        if let mostRecentReviewDate = restaurant.mostRecentReviewDate {
            if date > mostRecentReviewDate {
                restaurant.mostRecentReviewDate = date
            }
        } else {
            restaurant.mostRecentReviewDate = date
        }

        // determine and set the restaurant's reviewsAverage
        // map the starRatings for all reviews into a new array, sum them with the reduce method, before dividing to get the average
        if restaurant.reviewsAverage != nil {
            restaurant.reviewsAverage = restaurant.reviews.map({
                $0.starRating.rawValue
            }).reduce(0, +) / Double(restaurant.reviews.count)
        } else {
            restaurant.reviewsAverage = rating.rawValue
        }

        dismiss()
    }
}

#Preview {
    AddReviewView(restaurant: Restaurant(name: "My Restaurant", cuisineType: CuisineType(name: "American")))
}
