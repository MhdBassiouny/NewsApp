//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Muhammad Bassiouny on 12/18/22.
//

import Foundation
import Combine

class HomeViewModel {
    @Published var data = ArticlesData()
    
    var isRefreshingData = false
    private var anyCancellable: Set<AnyCancellable> = []
    
    func updateArticles(){
        if isRefreshingData {
            return
        } else {
            isRefreshingData.toggle()
        }
        
        DataSource.shared.getArticles(country:  data.selectedCountry,
                                      category: data.selectedCategory,
                                      page:     data.page)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                        case .finished:
                            print("Finished")
                        case .failure(let error):
                            print(error)
                    }
                },
                receiveValue: { [weak self] (value) in
                    self?.data.article += value.articles
                    self?.data.limit = value.totalResults
                    self?.isRefreshingData = false
                }).store(in: &anyCancellable)
        }
    
    func getArticle(in indexPath: IndexPath) -> Article{
        return data.article[indexPath.row]
    }
    
    func articlesCount() -> Int {
        data.article.count
    }
    
    func getTableViewCellCount() -> Int {
        return data.article.count
    }
    
    func shoudReloadData() -> Bool {
        return data.page == 1 || data.limit >= data.page * data.countPerPage
    }
    
    func getCurrenctPage() -> Int {
        return data.page
    }
    
    func addNextPage() {
        data.page += 1
        updateArticles()
    }
    
    func getArticleLimit() -> Int {
        return data.limit
    }
    
    func getCountPerPage() -> Int {
        return data.countPerPage
    }
    
    func resetData(){
        data.resetData()
    }

    
}
