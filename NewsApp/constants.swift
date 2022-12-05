//
//  constants.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import Foundation

struct K {
    static let filterData = [
        ["Title": "Category", "Value": K.categouryList],
        ["Title": "Country", "Value": K.countryList]
    ]
    
    static let categouryList = ["All Categories", "business", "entertainment", "generalhealth", "science", "sports", "technology"]
    static let countryList = ["Egypt", "United States", "Country4"]
    
    
    static let nibName = "NewsCell"
    
    struct CellIdentifier {
        static let news = "NewsCell"
        static let categoryFilter = "categoryCell"
    }
    
    
}
