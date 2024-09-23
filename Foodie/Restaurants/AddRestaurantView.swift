//
//  AddRestaurantView.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI
import SwiftData

/// View for adding a Restaurant
struct AddRestaurantView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CuisineType.name) var cuisineTypes: [CuisineType]

    @State private var restaurantNameInput = ""
    @State private var cuisineTypeSelection: CuisineType?


    var body: some View {
        VStack {
            TextField("Restaurant name", text: $restaurantNameInput)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.primaryTheme, lineWidth: 2)
                )
            Picker("Cuisine Type", selection: $cuisineTypeSelection) {
                Text("Choose Cuisine Type").tag(String?(nil))
                ForEach(cuisineTypes) { cuisineType in
                    Text(cuisineType.name).tag(Optional(cuisineType))
                }
            }
            .pickerStyle(.menu)
            .tint(.primaryTheme)

            // MARK: - Save & Cancel buttons
            Spacer()
            Button {
                save(restaurant: restaurantNameInput, cuisineType: cuisineTypeSelection)
            } label: {
                Text("Save").frame(maxWidth: .infinity)
                    .padding(.vertical)
            }.buttonStyle(PrimaryButtonStyle())
            Button {
                dismiss()
            } label: {
                Text("Cancel").frame(maxWidth: .infinity)
                    .padding(.vertical)
            }.buttonStyle(SecondaryButtonStyle())
        }
        .navigationTitle("Add Restaurant")
        .padding()
        .background(.surface)
    }
    
    /// Saves a new Restaurant to SwiftData
    /// - Parameters:
    ///   - name: name of the Restaurant to add
    ///   - cuisineType: type of Cuisine for the Restaurant
    private func save(restaurant name: String,
                      cuisineType: CuisineType?) {
        if let cuisineType = cuisineType {
            let newRestaurant = Restaurant(name: name, cuisineType: cuisineType)
            modelContext.insert(newRestaurant)
            dismiss()
        }
    }
}

#Preview {
    AddRestaurantView()
}
