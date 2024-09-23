//
//  Review.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import Foundation
import SwiftData

@Model
final class Review {

    @Attribute(.unique) var id: String = UUID().uuidString
    var restaurant: Restaurant
    var starRating: StarRating.StarInput
    var date: Date
    var notes: String

    init(restaurant: Restaurant, starRating: StarRating.StarInput, date: Date, notes: String) {
        self.restaurant = restaurant
        self.starRating = starRating
        self.date = date
        self.notes = notes
    }
}
