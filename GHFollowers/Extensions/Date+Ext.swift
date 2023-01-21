//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Kovs on 21.01.2023.
//

import Foundation


extension Date {
    // String -> Date -> String
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"   // "Jan 2013"
        
        return dateFormatter.string(from: self)
    }
    
}
