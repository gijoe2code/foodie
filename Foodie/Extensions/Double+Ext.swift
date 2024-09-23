//
//  Double+Ext.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/22/24.
//

typealias StarRating = Double

extension StarRating {

    enum StarInput: StarRating, Codable {
        case one = 1.0
        case two = 2.0
        case three = 3.0
        case four = 4.0
        case five = 5.0
    }
}
