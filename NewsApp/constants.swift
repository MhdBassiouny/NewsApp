//
//  constants.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import Foundation

struct K {
    static let categoryList = ["All Categories", "business", "entertainment", "generalhealth", "science", "sports", "technology"]
    
    static let countryList = [("eg", "Egypt"), ("ar", "Country2"), ("us", "United States"), ("be", "Country4")]
    
    static let nibName = "NewsCell"
    
    struct CellIdentifier {
        static let news = "NewsCell"
        static let categoryFilter = "categoryCell"
    }
}
