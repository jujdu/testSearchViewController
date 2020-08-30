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
    let searchVC = SearchVC()
    private lazy var searchController = UISearchController(searchResultsController: searchVC)
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
        searchController.showsSearchResultsController = true
        navigationItem.searchController = searchController
        navigationItem.title = "R6 Operators"
        definesPresentationContext = true
        searchController.delegate = self
    }

}

//MARK: - UISearchResultsUpdating Implementation

extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterOperators(with: searchController.searchBar.text!)
//        searchController.searchResultsController?.view.isHidden = false
        searchVC.tableView.reloadData()
    }
    
    private func filterOperators(with text: String) {
        searchVC.filteredOperators = operators.filter { r6Operator -> Bool in
            return r6Operator.name.lowercased().contains(text.lowercased())
        }
    }
    
}

//MARK: - UITableViewDataSource Implementation

extension MainVC: UITableViewDataSource, UITableViewDelegate {
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

extension MainVC: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.searchResultsController?.view.alpha = 0
//        searchController.searchResultsController?.view.isHidden = false
//        UIView.animate(withDuration: 0.2) {
//            searchController.searchResultsController?.view.alpha = 1
//        }
    }
}

