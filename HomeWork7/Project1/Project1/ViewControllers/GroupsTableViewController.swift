//
//  GroupsTableViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 05.03.2024.
//

import UIKit

class GroupsTableViewController: UIViewController {
    private var tableView: GroupsTableView!
    private var networkService: NetworkService!
    private var dataService: DataService!
    private let refreshControl = UIRefreshControl()
    var token: String
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupServices()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        fetchData()
    }
    private func setupTableView() {
        tableView = GroupsTableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
//        tableView.groupsDelegate = self
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    private func setupServices() {
        networkService = NetworkService(token: token)
        dataService = DataService()
    }
    private func fetchData() {
        DispatchQueue.main.async {
            self.refreshControl.beginRefreshing()
        }
        networkService.getGroups(completion: { [weak self] groups in

            DispatchQueue.main.async {
                self?.tableView.setGroups(groups)
                self?.dataService.putGroupsData(groups: groups)
                self?.setTitle(syncTime: nil)
                self?.refreshControl.endRefreshing()
            }
        }, onError: { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(error: error)
                let syncTime = self?.dataService.getGroupsSyncTime()
                self?.setTitle(syncTime: syncTime)
                self?.refreshControl.endRefreshing()
            }
        })
    }
    private func showAlert(error: Error) {
        let alertController = UIAlertController(title: "Ошибка", message: "При загрузке данных из сети произошла ошибка.\n" + error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    private func setTitle(syncTime: Date?) {
        if let syncTime = syncTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
            let formattedSyncTime = dateFormatter.string(from: syncTime)
            DispatchQueue.main.async {
                GroupsViewController.groupsTitle = "Друзья\nобновлено \(formattedSyncTime)"
                GroupsViewController.titleLabel.text = GroupsViewController.groupsTitle
                GroupsViewController.titleLabel.sizeToFit()
            }
        } else {
            DispatchQueue.main.async {
                GroupsViewController.groupsTitle = "Друзья"
                GroupsViewController.titleLabel.text = GroupsViewController.groupsTitle
                GroupsViewController.titleLabel.sizeToFit()

            }
        }
    }

    private func applyTheme() {
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        GroupsViewController.titleLabel.textColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
    }
    @objc private func refreshData(_ sender: UIRefreshControl) {
        fetchData()
        sender.endRefreshing()
    }
}
