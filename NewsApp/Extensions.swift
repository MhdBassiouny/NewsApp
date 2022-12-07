//
//  Extensions.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/28/22.
//

import UIKit

// MARK: - UIImage
extension UIImageView {
    func load(url: URL, spinner: UIActivityIndicatorView) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        spinner.stopAnimating()
                    }
                } else {
                    spinner.stopAnimating()
                }
            }
        }
    }
}
