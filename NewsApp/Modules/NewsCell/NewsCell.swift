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
    
    
    func setupCell(viewModel: NewsCellViewModel){
        newsTitle.text = viewModel.title
        newsDate.text = viewModel.publishedAt
        newsSource.text = viewModel.source
        let isArabic = viewModel.title.isArabic

        newsTitle.textAlignment = isArabic ? .right : .left
        newsRightImage.isHidden = isArabic ? false : true
        rightSpinner.isHidden = isArabic ? false : true
        newsLeftImage.isHidden = isArabic ? true : false
        leftSpinner.isHidden = isArabic ? true : false
        isArabic ? rightSpinner.startAnimating() : leftSpinner.startAnimating()
        
        let displayData = isArabic ? (image: newsRightImage, spinner: rightSpinner) : (image: newsLeftImage, spinner: leftSpinner)
        
        if let validURL = URL(string: viewModel.selectURL), let image = displayData.image, let spinner = displayData.spinner {
            image.load(url: validURL, spinner: spinner)
        } else {
            displayData.spinner?.stopAnimating()
        }
    }
}
