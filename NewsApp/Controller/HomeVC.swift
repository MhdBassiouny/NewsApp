//
//  ViewController.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var data = ArticlesData()
    let predictArabic = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.news)
        
        updateArticles()
    }
    
    
    func updateArticles(){
        DataSource.shared.getArticles(
            country:    self.data.selectedCountry,
            category:   self.data.selectedCategory,
            page:       self.data.page) { [weak self] response in
            
            switch response{
                case .success(let news):
                    self?.spinner.startAnimating()
                    self?.data.article += news.articles
                    self?.data.limit = news.totalResults
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.navigationItem.title = self?.data.selectedCategory
                        self?.spinner.stopAnimating()
                        self?.data.isRefreshing = false
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
                self?.data.resetData()
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
        return data.article.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = data.article[indexPath.row]
        let isArabic = predictArabic.evaluate(with: article.title)
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.news, for: indexPath) as! NewsCell

        cell.newsTitle.text = article.title
        cell.newsDate.text = article.publishedAt
        cell.newsSource.text = article.source.name
        
        cell.newsTitle.textAlignment = isArabic ? NSTextAlignment.right : NSTextAlignment.left
        cell.newsRightImage.isHidden = isArabic ? false : true
        cell.rightSpinner.isHidden = isArabic ? false : true
        cell.newsLeftImage.isHidden = isArabic ? true : false
        cell.leftSpinner.isHidden = isArabic ? true : false
        isArabic ? cell.rightSpinner.startAnimating() : cell.leftSpinner.startAnimating()
        
        let displayData = isArabic ? (image: cell.newsRightImage, spinner: cell.rightSpinner) : (image: cell.newsLeftImage, spinner: cell.leftSpinner)
        if let imageURL = article.urlToImage, let validURL = URL(string: imageURL), let image = displayData.image, let spinner = displayData.spinner {
            image.load(url: validURL, spinner: spinner)
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = data.article[indexPath.row]
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetailsVC
        
        detailsVC.selectedTitle = article.title
        detailsVC.selectedConteny = article.content
        detailsVC.selectURL = article.urlToImage
        detailsVC.isArabic = predictArabic.evaluate(with: article.title)

        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard data.page == 1 || data.limit >= data.page * data.countPerPage else { return }
        
        if indexPath.row == data.article.count - 2 {
            self.data.page += 1
            self.updateArticles()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if tableView == scrollView, position < -50, data.isRefreshing == false {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.data.isRefreshing = true
            }
        }
    }
}

