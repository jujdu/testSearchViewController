//
//  DetailsVC.swift
//  TestSearchController
//
//  Created by Michael Sidoruk on 29.08.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    public func update(_ name: String) {
        titleLabel.text = name
    }
}
