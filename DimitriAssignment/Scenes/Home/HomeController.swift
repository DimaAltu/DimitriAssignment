//
//  HomeController.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

class HomeController: UIViewController {
    
    var viewModel: HomeViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.dataSource = self
        tb.delegate = self
        tb.separatorStyle = .none
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Home"
        
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
        setupTableView()
        setupUI()
        bindListeners()
    }
    
    private func setupSubViews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupUI() {
        title = "Register"
    }
    
    private func setupTableView() {
        tableView.register(types: [
            HomeImageCell.self
        ])
    }
    
    private func bindListeners() {
        viewModel.rows.bind { rows in
            self.tableView.reloadData()
        }
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.rows.value[indexPath.row]
        let cell = tableView.dequeueReusable(viewModel: viewModel, for: indexPath)
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToDetailsPage(modelIndex: indexPath.row)
    }
}
