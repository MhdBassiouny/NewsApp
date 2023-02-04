//
//  FilterVC.swift
//  NewsApp
//
//  Created by M Bassiouny on 11/29/22.
//

import UIKit
import Combine

class FilterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel =  FilterViewModel()
    var selectedData: (categoryIndex: Int?, counteryIndex: Int?)
    @Published var toBeSelected: (category: String, country: String) = ("", "")
    var anyCancellable: Set<AnyCancellable> = []
    //public var completion: ((_ category: String, _ country: String) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let categoryIndexPath = self.selectedData.categoryIndex {
            self.selectOldFilters(raw: categoryIndexPath, setion: 0)
        }

        if let countryIndexPath = self.selectedData.counteryIndex {
            self.selectOldFilters(raw: countryIndexPath, setion: 1)
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
        
        // completion?(selectedCategory, selectedCountry)
        toBeSelected = (selectedCategory, selectedCountry)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func selectOldFilters(raw: Int, setion: Int) {
        self.tableView.selectRow(at: IndexPath(row: raw, section: setion), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: raw)!)
        self.tableView.cellForRow(at: IndexPath(row: raw, section: setion))?.accessoryType = .checkmark
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
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

