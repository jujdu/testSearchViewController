//
//  MainVC.swift
//  TestSearchController
//
//  Created by Michael Sidoruk on 29.08.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Views
    
    let customView = MainView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive
    }

    //MARK: - Private Properties

    private let operators: [RainbowSixOperator] = RainbowSixOperator.generateOperators()
    private var filteredOperators: [RainbowSixOperator] = []
    private var dataSource: [RainbowSixOperator] {
        if isFiltering && !searchBarIsEmpty {
            return filteredOperators
        } else {
            return operators
        }
    }
    
    //MARK: - Life Cycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        //search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find your R6 operator"
        navigationItem.searchController = searchController
        navigationItem.title = "R6 Operators"
        definesPresentationContext = true
    }

}

//MARK: - UISearchResultsUpdating Implementation

extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterOperators(with: searchController.searchBar.text!)
        customView.tableView.reloadData()
    }
    
    private func filterOperators(with text: String) {
        filteredOperators = operators.filter { r6Operator -> Bool in
            return r6Operator.name.lowercased().contains(text.lowercased())
        }
    }
    
}

//MARK: - UITableViewDataSource Implementation

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = DetailsVC()
        let name = dataSource[indexPath.row].name
        detailsVC.update(name)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - UITableViewDelegate Implementation

extension MainVC: UITableViewDelegate {
    
}

