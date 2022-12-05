//
//  FilterVC.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/29/22.
//

import UIKit

class FilterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCategoryIndexPath: Int?
    var selectedCountryIndexPath: Int?
    
    
    // completion closure for passing the data back to teh main view
    public var completion: ((_ category: String, _ country: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            if let categoryIndexPath = self.selectedCategoryIndexPath {
                self.tableView.selectRow(at: IndexPath(row: categoryIndexPath, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                self.tableView.cellForRow(at: IndexPath(row: categoryIndexPath, section: 0))?.accessoryType = .checkmark
            }
            
            if let countryIndexPath = self.selectedCategoryIndexPath {
                self.tableView.selectRow(at: IndexPath(row: countryIndexPath, section: 1), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                self.tableView.cellForRow(at: IndexPath(row: countryIndexPath, section: 1))?.accessoryType = .checkmark
            }
        }
    }
    
    
    @IBAction func filterButton(_ sender: UIButton) {
        var selectedCategory = ""
        var selectedCountry = ""
        
        if let selectedCategoryIndexPath = tableView.indexPathsForSelectedRows?.first(where: { $0.section == 0 }), let categoryList = K.filterData[0]["Value"] as? [String] {
            selectedCategory = categoryList[selectedCategoryIndexPath.row]
        }
        
        if let selectedCountryIndexPath = tableView.indexPathsForSelectedRows?.first(where: { $0.section == 1 }), let countryList = K.filterData[1]["Value"] as? [String] {
            selectedCountry = countryList[selectedCountryIndexPath.row]
        }
        
        completion?(selectedCategory, selectedCountry)
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - tableView

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return K.filterData.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let title = K.filterData[section]["Title"] as? String {
            return title
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let values = K.filterData[section]["Value"] as? [String] {
            return values.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.categoryFilter, for: indexPath)
        guard let section = K.filterData[indexPath.section]["Value"] as? [String] else {
            return UITableViewCell()
        }
        cell.textLabel?.text = section[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPath = tableView.indexPathsForSelectedRows?.first(where: { $0.section == indexPath.section }) {
            tableView.deselectRow(at: selectedIndexPath, animated: false)
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
}

