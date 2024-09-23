//
//  CuisineType.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftData

@Model
final class CuisineType {

    @Attribute(.unique) var name: String

    init(name: String) {
        self.name = name
    }
}
