//
//  ArticlesData.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/29/22.
//

import Foundation

struct ArticlesData {
    var article: [Article] = []
    var countPerPage = 10
    var limit: Int { return article.count }
    var paginationNews = [Article]()
    var currentNewsCount: Int { return paginationNews.count }
    var selectedCountry = ""
    var selectedCategory = "All Categories"
    
    mutating func setInitialNews() {
        paginationNews = []
        if limit <= countPerPage {
            paginationNews = article
        } else {
            for i in 0..<countPerPage {
                paginationNews.append(article[i])
            }
        }
    }
    
    
    mutating func addPagination() {
        guard limit > countPerPage else { return }
        
        if currentNewsCount >= limit - countPerPage {
            for i in currentNewsCount..<limit{
                paginationNews.append(article[i])
            }
        } else {
            for i in currentNewsCount..<currentNewsCount + 10{
                paginationNews.append(article[i])
            }
        }
    }
}
