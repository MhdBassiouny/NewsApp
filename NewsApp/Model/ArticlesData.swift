//
//  ArticlesData.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/29/22.
//

import Foundation

struct ArticlesData {
    var article: [Article] = []
    var countPerPage = 20
    var page = 1
    var limit = 0
    var selectedCountry = "United States"
    var selectedCategory = "All Categories"
    
    
    mutating func resetData(){
        self.article = []
        self.page = 1
        self.limit = 0
    }
}
