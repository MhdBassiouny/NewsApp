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
    
    var selectedTitle: String?
    var selectedConteny: String?
    var selectURL: String?
    var isArabic = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
    
        newsTitle.text = selectedTitle
        newsDescription.text = selectedConteny
        if let urlString = selectURL, let imgURL = URL(string: urlString) {
            newsImage.load(url: imgURL, spinner: spinner)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        titleView.layer.cornerRadius = 10
        newsTitle.textAlignment = isArabic ? NSTextAlignment.right : NSTextAlignment.left
        newsDescription.textAlignment = isArabic ? NSTextAlignment.right : NSTextAlignment.left
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
    }
}
