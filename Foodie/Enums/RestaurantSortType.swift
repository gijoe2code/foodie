//
//  RestaurantSortType.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/23/24.
//

import Foundation

enum RestaurantSortType: String, Equatable, CaseIterable {
    case avgRating = "Avg Rating"
    case name = "Name"
    case mostRecentReview = "Most Recent Review"

    var sortType: SortDescriptor<Restaurant> {
        switch self {
        case .avgRating: return SortDescriptor(\Restaurant.reviewsAverage, order: .reverse)
        case .name: return SortDescriptor(\.name)
        case .mostRecentReview: return SortDescriptor(\Restaurant.mostRecentReviewDate, order: .reverse)
        }
    }
}
