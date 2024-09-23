//
//  ReviewsView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI
import SwiftData

/// Displays a list of Reviews for a given Restaurant
struct ReviewsView: View {

    @Environment(\.modelContext) private var modelContext
    @Bindable var restaurant: Restaurant

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Restaurant row
            RatingRowView(rating: restaurant.reviewsAverage, isAverage: true) {
                Text(restaurant.name)
                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 16)))
            }
            .padding(.horizontal)
            .background(.secondaryTheme)

            // MARK: - List of reviews
            ScrollView {
                ForEach(restaurant.reviews, id: \.self) { review in
                    RatingRowView(heading: review.date.toString(), rating: review.starRating.rawValue) {
                        Text("\(review.notes)").font(Font.system(size: UIFontMetrics.default.scaledValue(for: 14)))
                    }
                    Divider()
                }
                Spacer()
            }.padding(.horizontal)
        }
        // MARK: - Toolbar
        .navigationTitle("Reviews")
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    AddReviewView(restaurant: restaurant)
                } label: {
                    Label("Add Review", systemImage: "plus")
                }
            }
        }
        .toolbarBackground(.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(.surface)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self, configurations: config)
    let americanCuisine = CuisineType(name: "American")
    let restaurant = Restaurant(name: "My Restaurant", cuisineType: americanCuisine)
    container.mainContext.insert(americanCuisine)
    container.mainContext.insert(restaurant)
        for i in 1 ..< 5 {
            let review = Review(restaurant: restaurant, starRating: .five, date: Date(), notes: "Notes \(i)")
            container.mainContext.insert(review)
            restaurant.reviews.append(review)
        }

    return ReviewsView(restaurant: restaurant)
        .modelContainer(container)
}
