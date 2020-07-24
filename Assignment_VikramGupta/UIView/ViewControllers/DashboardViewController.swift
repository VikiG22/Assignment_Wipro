//
//  DashboardViewController.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

  // View Model
  private lazy var viewModel: FactsViewModel = FactsViewModel()
  // Cell Reuse Identifier
  static let cellIdentifier: String = "cell"

  // Initilisation tableview with estamated height for cell
  private var tableView: UITableView = {
    let tableview = UITableView()
    tableview.translatesAutoresizingMaskIntoConstraints = false
    tableview.backgroundColor = .white
    tableview.estimatedRowHeight = 100
    tableview.rowHeight = UITableView.automaticDimension
    tableview.register(DashboardTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    return tableview
  }()

  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Facts"
    designUI()
    tableView.isHidden = true
    view.backgroundColor = .white
  }

  // Setting initial setup view which is going to be called when view going to load into memory
  private func designUI() {
    view.addSubview(tableView) // Adding tableview in controller view
    setupAutoLayout()
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    // Add Refresh Control to Table View
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    tableView.refreshControl?.tintColor = .black
    getFactsDetials()
    self.activityStartAnimating(activityColor: .black, backgroundColor: .clear)
  }

  // Adding autolayout constraints on table View
  private func setupAutoLayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }

  // Request for country facts details
  private func getFactsDetials() {
    viewModel.requestData(apiName: ApiName.facts) { (success, error) in
        DispatchQueue.main.async {
            if success {
                self.navigationItem.title = "Facts"
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            else {
                self.tableView.isHidden = true
                self.showAlert(message: error?.localizedDescription, delay: 0.3)
            }
            self.tableView.refreshControl?.endRefreshing()
            self.activityStopAnimating()
        }
    }
  }

  // MARK: ACTIONS
  // Refresh facts list form the API call
  @objc private func refreshAction() {
    getFactsDetials()
  }
}

// MARK: UITableView DataSource
extension DashboardViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.cellIdentifier, for: indexPath) as? DashboardTableViewCell else { return UITableViewCell() }
    if let item = viewModel.getRow(at: indexPath.row) {
      cell.setCellData(result: item)
    }
    return cell
  }
}
