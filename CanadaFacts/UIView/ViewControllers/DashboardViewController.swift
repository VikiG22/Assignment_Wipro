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
    private lazy var factsViewModel: FactsViewModel = FactsViewModel()
    // Cell Reuse Identifier
    static let cellIdentifier: String = "cell"
    
    // Initilisation tableview with estamated height for cell
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        tableview.estimatedRowHeight = 80
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(DashboardTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableview
    }()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
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
        tableView.tableFooterView = UIView()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font_Helvetica_Neue_Bold, size: FONT_SIZE_15)!, .foregroundColor: UIColor.white]
        getFactsDetials()
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
        guard NetworkManager.sharedInstance.reachability.connection != .unavailable else {
            self.showAlert(message: ApiError.networkNotAvilable.rawValue, delay: 0.3)
            self.tableView.refreshControl?.endRefreshing()
            return
        }
        self.activityStartAnimating(activityColor: .black, backgroundColor: .clear)
        factsViewModel.requestData(apiName: ApiName.facts) { (success, error) in
            DispatchQueue.main.async {
                if success {
                    self.navigationItem.title = self.factsViewModel.getTitle()
                    self.tableView.reloadData()
                }
                else {
                    self.showAlert(message: error?.rawValue, delay: 0.3)
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
    
    // Method for no data available
    func setNoDataAvailable(){
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.text = "No Data Available"
        emptyLabel.textColor = lightGrayColor()
        emptyLabel.font = UIFont(name:Font_Helvetica_Neue, size:FONT_SIZE_22)
        emptyLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

// MARK: UITableView DataSource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if factsViewModel.numberOfRows() == 0 || factsViewModel.numberOfRows() == nil {
            setNoDataAvailable()
            return 0
        }
        return factsViewModel.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.cellIdentifier, for: indexPath) as? DashboardTableViewCell else { return UITableViewCell() }
        if let item = factsViewModel.getRow(at: indexPath.row) {
            cell.setCellData(result: item)
        }
        return cell
    }
}
