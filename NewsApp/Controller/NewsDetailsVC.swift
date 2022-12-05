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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.cornerRadius = 10
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        newsTitle.text = selectedTitle
        newsDescription.text = selectedConteny
        if let urlString = selectURL, let imgURL = URL(string: urlString) {
            newsImage.load(url: imgURL, spinner: spinner)
        }
    }
}
