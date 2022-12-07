//
//  NewsCell.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsCell: UIView!
    @IBOutlet weak var newsLeftImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var leftSpinner: UIActivityIndicatorView!
    @IBOutlet weak var newsRightImage: UIImageView!
    @IBOutlet weak var rightSpinner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
