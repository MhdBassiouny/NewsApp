//
//  ViewController.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    var data = ArticlesData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.news)
        
        updateArticles()
    }
    
    
    func updateArticles(){
        DataSource.shared.getArticles(country: self.data.selectedCountry, category: self.data.selectedCategory) { [weak self] response in
            switch response{
                case .success(let articles):
                    self?.data.article = articles
                    self?.data.setInitialNews()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.navigationItem.title = self?.data.selectedCategory
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {        
        let filterCV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Filter") as! FilterVC
        
        if let categoryPath = K.categouryList.firstIndex(of: data.selectedCategory) {
            filterCV.selectedCategoryIndexPath = categoryPath
        }
        if let countryPath = K.countryList.firstIndex(of: data.selectedCountry) {
            filterCV.selectedCountryIndexPath = countryPath
        }
        
        filterCV.completion = { [weak self] selectedCategory, selectedCountry in
            DispatchQueue.main.async {
                self?.data.selectedCategory = selectedCategory
                self?.data.selectedCountry = selectedCountry
                
                self?.updateArticles()
            }
        }
        
        let vc = UINavigationController(rootViewController: filterCV)
        present(vc, animated: true)
    }
}


//MARK: - TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.paginationNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = data.paginationNews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.news, for: indexPath) as! NewsCell

        cell.newsTitle.text = article.title
        cell.newsDate.text = article.publishedAt
        cell.newsSource.text = article.source.name
        if let imageURL = article.urlToImage, let validURL = URL(string: imageURL) {
            cell.newsImage.load(url: validURL)
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = data.paginationNews[indexPath.row]
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetailsVC
        
        detailsVC.selectedTitle = article.title
        detailsVC.selectedConteny = article.content
        detailsVC.selectURL = article.urlToImage
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard data.currentNewsCount < data.limit else { return }
       
        let position = scrollView.contentOffset.y + (scrollView.frame.size.height)
        if position > (tableView.contentSize.height - 100) {
            self.data.addPagination()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        indexPath.row = data.paginationNews.count - 2
//    }
}

