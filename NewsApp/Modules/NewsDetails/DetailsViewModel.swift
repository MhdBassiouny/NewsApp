//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Muhammad Bassiouny on 12/18/22.
//

import Foundation

class DetailsViewModel{
    var selectedTitle: String
    var selectedConteny: String
    var selectURL: String
    
    init(article: Article) {
        self.selectedTitle = article.title
        self.selectedConteny = article.content ?? "No Content"
        self.selectURL = article.urlToImage ?? ""
    }
}
