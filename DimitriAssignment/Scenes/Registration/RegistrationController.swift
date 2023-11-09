//
//  RegistrationController.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

class RegistrationController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.dataSource = self
        tb.separatorStyle = .none
        return tb
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
        setupTableView()
        bindListeners()
        setupUI()
    }
    
    private func setupSubViews() {
        self.view.addSubview(tableView)
        self.view.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupUI() {
        tableView.contentInset = .init(top: 100, left: 0, bottom: 0, right: 0)
        title = "Register"
    }
    
    private func setupTableView() {
        tableView.register(types: [
            InputCell.self
        ])
    }
    
    private func bindListeners() {
        viewModel.rows.bind { rows in
            self.tableView.reloadData()
        }
    }
    
    @objc private func registerTapped() {
        viewModel.didTappedRegister()
    }
}

extension RegistrationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.rows.value[indexPath.row]
        let cell = tableView.dequeueReusable(viewModel: viewModel, for: indexPath)
        cell.viewModel = viewModel
        return cell
    }
}

