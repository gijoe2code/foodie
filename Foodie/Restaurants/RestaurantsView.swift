//
//  RestaurantsView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI
import SwiftData

/// Displays a list of Restaurants
struct RestaurantsView: View {

    @Environment(\.modelContext) private var modelContext
    @Query var restaurants: [Restaurant]

    init(sort: SortDescriptor<Restaurant>) {
        _restaurants = Query(sort: [sort])
    }

    var body: some View {
        List {
            ForEach(restaurants) { restaurant in
                NavigationLink {
                    ReviewsView(restaurant: restaurant)
                } label: {
                    RatingRowView(rating: restaurant.reviewsAverage) {
                        HStack {
                            Text(restaurant.name)
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 16)))
                            Spacer()
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.secondaryTheme)
                                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 17)))

                                Text("\(restaurant.reviews.count)")
                                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 14)))
                            }
                        }
                    }
                }
                .swipeActions(edge: .leading) {
                    EditButton().tint(.green)
                }
            }
            .onDelete(perform: { indexSet in
                delete(at: indexSet)
            })
        }
        .background(.surface)
        .toolbar{
            EditButton()
        }
    }

    func delete(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(restaurants[offset])
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self, configurations: config)
    let americanCuisine = CuisineType(name: "American")
    container.mainContext.insert(americanCuisine)
        for i in 1 ..< 5 {
            let restaurant = Restaurant(name: "Restaurant \(i)", cuisineType: americanCuisine)
            container.mainContext.insert(restaurant)
        }

    return RestaurantsView(sort: RestaurantSortType.avgRating.sortType)
        .modelContainer(container)
}
