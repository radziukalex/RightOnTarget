//
//  ResultViewController.swift
//  Right on target
//
//  Created by Admin on 21.01.2023.
//

import Foundation
import UIKit

protocol ResultDelegate: NSObject {
    func addResult(_ ourResultAdd: ResultItem)
}

struct ResultItem {
    let points: String
    let date: String
}

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    var model = GameModel()
    
    init(model: GameModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        setupMyTable()
        setupMyNavBar()
    }
    
    private func setupMyTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupMyNavBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addResultActionButton))
    }
    
    @objc private func addResultActionButton() {
        let addResultViewController = AddResultViewController()
        addResultViewController.resultDelegate = self
        present(addResultViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        }
        configure(cell: cell, for: indexPath)
        return cell
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.ourResultsAfterRound.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let config = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .normal, title: "Delete", handler: { [weak self] _, view, completion in
            self?.model.removeAt(index: indexPath.row)
            tableView.reloadData()
            completion(true)
        })])
        return config
    }
    
}

extension ResultViewController: ResultDelegate {
    
    func addResult(_ ourResultAdd: ResultItem) {
        self.dismiss(animated: true, completion: { [weak self] in
            self?.model.addToResult(newItem: ourResultAdd)
            self?.tableView.reloadData()
        })
    }
    
    private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        var config = cell.defaultContentConfiguration()
        let item = model.ourResultsAfterRound[indexPath.row]
        config.text = "Результат \(indexPath.row + 1) раунда: \(item.points)"
        config.secondaryText = "Время: \(item.date)"
        cell.contentConfiguration = config
    }
}

