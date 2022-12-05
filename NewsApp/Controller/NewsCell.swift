//
//  NewsCell.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsCell: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCell.layer.cornerRadius = 10
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}