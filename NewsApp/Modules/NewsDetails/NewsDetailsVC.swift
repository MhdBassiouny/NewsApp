//
//  NewsDetailsVC.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit


class NewsDetailsVC: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: DetailsViewModel
    
//    init(viewModel: DetailsViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: "NewsDetailsVC", bundle: nil)
//
//    }
    
    // to be used with storyboard
    init?(viewModel: DetailsViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    
    override func viewDidLayoutSubviews() {
        setupView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        stopAnimating(self.spinner)
    }
    
    
    private func setupView(){
        titleView.layer.cornerRadius = 10
        
        spinner.startAnimating()
        let isArabic = viewModel.selectedTitle.isArabic
        newsTitle.textAlignment = isArabic ? .right : .left
        newsDescription.textAlignment = isArabic ? .right : .left
    }
    
    
    private func setupData(){
        newsTitle.text = viewModel.selectedTitle
        newsDescription.text = viewModel.selectedConteny
        if let imgURL = URL(string: viewModel.selectURL) {
            newsImage.load(url: imgURL, spinner: spinner)
        } else { spinner.stopAnimating() }
    }
    
    
    private func stopAnimating(_ spinner: UIActivityIndicatorView){
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
    }
}
