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
        filterCV.completion = { [weak self] selectedCategory in
            DispatchQueue.main.async {
                self?.data.selectedCategory = selectedCategory
                self?.updateArticles()
            }
        }
        let vc = UINavigationController(rootViewController: filterCV)
        present(vc, animated: true)
    }
}


//MARK: - TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.article.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = data.article[indexPath.row]
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
        let article = data.article[indexPath.row]
        
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetailsVC
        
        detailsVC.selectedTitle = article.title
        detailsVC.selectedConteny = article.content
        detailsVC.selectURL = article.urlToImage
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

