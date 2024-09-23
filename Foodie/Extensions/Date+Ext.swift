//
//  Date+Ext.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/22/24.
//

import Foundation

extension Date {
    func toString() -> String {
        let df = DateFormatter()
        // format example: Sunday, Sep 22, 2024
        df.dateFormat = "EEEE, MMM dd, YYYY"
        return df.string(from: self)
    }
}
