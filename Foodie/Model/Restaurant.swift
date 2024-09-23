//
//  Restaurant.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import Foundation
import SwiftData

@Model
final class Restaurant {

    @Attribute(.unique) var id: String = UUID().uuidString

    var name: String
    var cuisineType: CuisineType
    var reviews: [Review]

    var mostRecentReviewDate: Date?
    var reviewsAverage: Double?

    init(name: String,
         cuisineType: CuisineType) {
        self.name = name
        self.cuisineType = cuisineType
        self.reviews = []
    }
}
