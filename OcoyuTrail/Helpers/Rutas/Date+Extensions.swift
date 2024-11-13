//
//  Date+Extensions.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 12/11/24.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)-\(month)-\(day)"
    }
}
