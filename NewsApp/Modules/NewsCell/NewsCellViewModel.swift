//
//  NewsCellViewModel.swift
//  NewsApp
//
//  Created by Muhammad Bassiouny on 12/18/22.
//

import Foundation

class NewsCellViewModel {
    var title: String
    var publishedAt: String
    var source: String
    var selectURL: String
    
    init(article: Article) {
        self.title = article.title
        self.publishedAt = article.publishedAt.dateFromTimestamp?.toDuration() ?? ""
        self.source = article.source.name
        self.selectURL = article.urlToImage ?? ""
    }
}
