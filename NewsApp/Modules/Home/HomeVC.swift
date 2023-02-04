//
//  ViewController.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var cancellable: Set<AnyCancellable> = []
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setBinder()
        viewModel.updateArticles()
    }
    
    
    func setBinder() {
        viewModel.$data.sink(receiveValue: { [weak self] data in
            self?.spinner.startAnimating()
            self?.tableView.reloadData()
            self?.navigationItem.title = self?.viewModel.data.selectedCategory
            self?.spinner.stopAnimating()
        }
        ).store(in: &cancellable)
    }
    
    
    func registerCell(){
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.news)
    }
    
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        let filterCV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Filter") as! FilterVC
        
        if let categoryPath = K.categouryList.firstIndex(of: viewModel.data.selectedCategory) {
            filterCV.selectedData.categoryIndex = categoryPath
        }
        
        if let countryPath = K.countryList.firstIndex(of:viewModel.data.selectedCountry) {
            filterCV.selectedData.counteryIndex = countryPath
        }
        
//        filterCV.completion = { [weak self] selectedCategory, selectedCountry in
//            DispatchQueue.main.async {
//                self?.viewModel.resetData()
//                self?.viewModel.data.selectedCategory = selectedCategory
//                self?.viewModel.data.selectedCountry = selectedCountry
//                self?.viewModel.updateArticles()
//            }
//        }
        
        filterCV.$toBeSelected.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] value in
            self?.viewModel.resetData()
            self?.viewModel.data.selectedCategory = value.category
            self?.viewModel.data.selectedCountry = value.country
            self?.viewModel.updateArticles()
        }).store(in: &cancellable)
        
        let vc = UINavigationController(rootViewController: filterCV)
        present(vc, animated: true)
    }
}


//MARK: - TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableViewCellCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.getArticle(in: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.news, for: indexPath) as! NewsCell
        cell.setupCell(viewModel: NewsCellViewModel(article: article))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.getArticle(in: indexPath)
        let viewModel = DetailsViewModel(article: article)
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            identifier: "NewsDetails",
            creator: { coder in
                NewsDetailsVC(viewModel: viewModel, coder: coder)
            })
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if viewModel.shoudReloadData(), indexPath.row == viewModel.articlesCount() - 2 {
            self.viewModel.addNextPage()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if tableView == scrollView && position < -50 && !viewModel.isRefreshingData {
            DispatchQueue.main.async {
                self.viewModel.resetData()
                self.viewModel.updateArticles()
                self.tableView.reloadData()
            }
        }
    }
}

