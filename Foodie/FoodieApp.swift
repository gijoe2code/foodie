//
//  FoodieApp.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI
import SwiftData

@main
struct FoodieApp: App {

    let sharedModelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Restaurant.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            DispatchQueue.main.async {
                do {
                    // If there are no Cousine Types, add default ones
                    if try container.mainContext.fetchCount(FetchDescriptor<Restaurant>()) == 0 {
                        let defaultCuisineTypes = [
                            CuisineType(name: "American"),
                            CuisineType(name: "Chinese"),
                            CuisineType(name: "French"),
                            CuisineType(name: "Greek"),
                            CuisineType(name: "Indian"),
                            CuisineType(name: "Italian"),
                            CuisineType(name: "Korean"),
                            CuisineType(name: "Middle Eastern"),
                            CuisineType(name: "Spanish"),
                            CuisineType(name: "Thai"),
                            CuisineType(name: "Vietnamese"),
                            CuisineType(name: "Other")
                        ]

                        for defaultCuisineType in defaultCuisineTypes {
                            container.mainContext.insert(defaultCuisineType)
                        }
                    }
                } catch {
                    fatalError("Could not add default cuisine types: \(error) ")
                }
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RestaurantsPickerWrapperView()
        }
        .modelContainer(sharedModelContainer)
    }
}
