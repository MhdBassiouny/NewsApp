//
//  DataSource.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import Foundation
import Alamofire
import Combine

struct DataSource {
    static var shared = DataSource()
    private init(){}
    
    private let apiKey = "cd4de2a6237c4a939f56e648a2e547fb"
    
    mutating func getArticles(country: String, category: String, page: Int) -> Future<News, Error>  {
        
        var pathCategory: String {
            if category == "All Categories" {
                return ""
            } else {
                return category
            }
        }
        var pathCountry: String {
            if pathCategory == "" &&  country == "" {
                return "us"
            } else {
                return K.countryCodes[country, default: "us"]
            }
        }
        
        let url = URL(string:
            "https://newsapi.org/v2/top-headlines?country=\(pathCountry)&category=\(pathCategory)&page=\(page)&apiKey=\(apiKey)")
        
        return Future { promise in
            guard let validURL = url else {
                return
            }
            
            AF.request(validURL, method: .get, encoding: JSONEncoding.default).validate().responseDecodable(of: News.self) { (response) in
                guard let news = response.value, response.error == nil else {
                    promise(.failure(response.error!))
                    return
                }
                promise(.success(news))
            }
        }
    }
}
