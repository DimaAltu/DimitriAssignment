//
//  LoginController.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 03.11.23.
//

import UIKit

class LoginController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.dataSource = self
        tb.separatorStyle = .none
        return tb
    }()
    
    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel: LoginViewModel!
    
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
        self.view.addSubview(stack)
        stack.addArrangedSubview(loginButton)
        stack.addArrangedSubview(registerButton)
    }
    
    private func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupUI() {
        tableView.contentInset = .init(top: 100, left: 0, bottom: 0, right: 0)
        title = "Login"
    }
    
    private func setupTableView() {
        tableView.register(types: [
            InputCell.self
        ])
    }
    
    private func bindListeners() {
        viewModel.email.bind { emailString in
            print(emailString)
        }
        
        viewModel.password.bind { password in
            print(password)
        }
        
        viewModel.rows.bind { [weak self] rows in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func loginTapped() {
        viewModel.didTappedLogin()
    }
    
    @objc private func registerTapped() {
        viewModel.didTappedRegister()
    }
}

extension LoginController: UITableViewDataSource {
    
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
