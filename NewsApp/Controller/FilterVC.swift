//
//  FilterVC.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/29/22.
//

import UIKit

class FilterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // completion closure for passing the data back to teh main view
    public var completion: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
    }
}


//MARK: - tableView

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.categoryFilter, for: indexPath)
        cell.textLabel?.text = K.categoryList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(K.categoryList[indexPath.row]) //giving the closure a value to pass back
        self.dismiss(animated: true, completion: nil)
    }
}

