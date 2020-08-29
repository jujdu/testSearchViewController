//
//  MainView.swift
//  TestSearchController
//
//  Created by Michael Sidoruk on 29.08.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    //MARK: - Views
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    //MARK: - Properties

    weak var delegate: (UITableViewDelegate & UITableViewDataSource)? {
        willSet {
            tableView.delegate = newValue
            tableView.dataSource = newValue
        }
    }
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
