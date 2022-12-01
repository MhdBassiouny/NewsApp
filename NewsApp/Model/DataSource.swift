//
//  DataSource.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import Foundation
import Alamofire

struct DataSource {
    static var shared = DataSource()
    private let apiKey = "cd4de2a6237c4a939f56e648a2e547fb"

    func getArticles(country: String, category: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        var pathCategory: String {
            if category == "All Categories" {
                return ""
            } else {
                return category
            }
        }
        var pathCountry: String {
            if pathCategory == "" && country == "" {
                return "us"
            } else {
                return country
            }
        }
        
        let url = URL(string:
            "https://newsapi.org/v2/top-headlines?country=\(pathCountry)&category=\(pathCategory)&apiKey=\(apiKey)")
        
        guard let validURL = url else {
            return
        }
        
        AF.request(validURL, method: .get, encoding: JSONEncoding.default).validate().responseDecodable(of: News.self) { (response) in
            guard let news = response.value, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            completion(.success(news.articles))
        }
    }
}
