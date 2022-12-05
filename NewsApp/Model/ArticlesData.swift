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
    var selectedCountry = ""
    var selectedCategory = "All Categories"
    
    mutating func resetData(){
        self.article = []
        self.page = 1
        self.limit = 0
    }

    
//    mutating func setInitialNews() {
//        paginationNews = []
//        if limit <= countPerPage {
//            paginationNews = article
//        } else {
//            for i in 0..<countPerPage {
//                paginationNews.append(article[i])
//            }
//        }
//    }
//
//
//    mutating func addPagination() {
//        guard limit > countPerPage else { return }
//
//        if currentNewsCount >= limit - countPerPage {
//            for i in currentNewsCount..<limit{
//                paginationNews.append(article[i])
//            }
//        } else {
//            for i in currentNewsCount..<currentNewsCount + 10{
//                paginationNews.append(article[i])
//            }
//        }
//    }
}
