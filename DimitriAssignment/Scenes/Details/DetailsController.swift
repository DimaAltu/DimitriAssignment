//
//  DetailsController.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

class DetailsController: UIViewController {

    var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.dataSource = self
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
            HomeImageCell.self,
            DetailInfoCell.self,
            SpacerCell.self
        ])
    }
    
    private func bindListeners() {
        viewModel.sections.bind { rows in
            self.tableView.reloadData()
        }
    }
}

extension DetailsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections.value[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.sections.value[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusable(viewModel: viewModel, for: indexPath)
        cell.viewModel = viewModel
        return cell
    }
}

