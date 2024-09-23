//
//  RestaurantsPickerWrapperView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/22/24.
//

import SwiftUI
import SwiftData

/// Wrapper for the Restaurants list, which helps update SwiftData
struct RestaurantsPickerWrapperView: View {

    @Environment(\.sizeCategory) var sizeCategory

    @Query var restaurants: [Restaurant]

    @State private var sortOrder = RestaurantSortType.avgRating.sortType

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Sort by:")
                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 14)))
                    .padding(.top)
                Picker("", selection: $sortOrder) {
                    Text(RestaurantSortType.avgRating.rawValue)
                        .tag(RestaurantSortType.avgRating.sortType)
                    Text(RestaurantSortType.name.rawValue)
                        .tag(RestaurantSortType.name.sortType)
                    Text(RestaurantSortType.mostRecentReview.rawValue)
                        .tag(RestaurantSortType.mostRecentReview.sortType)
                }
                .pickerStyle(.segmented)

                RestaurantsView(sort: sortOrder)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Foodie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddRestaurantView()
                    } label: {
                        Label("Add Restaurant", systemImage: "plus")
                    }
                }
            }
            .toolbarBackground(.surface, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(.surface)
        }
        .onAppear(perform: {
            // This allows uneven widths for sections of segmented picker
            UISegmentedControl.appearance().apportionsSegmentWidthsByContent = true
            UISegmentedControl.appearance().selectedSegmentTintColor = .secondaryTheme
        })
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

    return RestaurantsPickerWrapperView()
        .modelContainer(container)
}
