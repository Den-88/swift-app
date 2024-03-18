//
//  GroupsTableViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 05.03.2024.
//

import UIKit

final class GroupsTableViewController: UITableViewController {
    var token: String
    lazy private var networkService = NetworkService(token: token)
    private var models: [Groups] = []
    private var dataService = DataService()

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

        tableView.register(GroupsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        models = dataService.getGroupsData()
        tableView.reloadData()

        networkLoad(sender: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GroupsViewController.titleLabel.textColor = Theme.currentTheme.textColor
        view.backgroundColor = Theme.currentTheme.backgroundColor
        self.tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? GroupsCustomTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.setupGroups(group: model)
        return cell
    }
    
    func networkLoad(sender: UIRefreshControl?) {
        networkService.getGroups(completion: { [self] groups in
            self.models = groups
            self.dataService.putGroupsData(groups: groups)

            DispatchQueue.main.async {
                GroupsViewController.groupsTitle = "Группы"
                GroupsViewController.titleLabel.text = GroupsViewController.groupsTitle
                GroupsViewController.titleLabel.sizeToFit()
                self.tableView.reloadData()
                guard let refreshControl = sender else {
                    return
                }
                refreshControl.endRefreshing()
            }
        }, onError: { error in
            self.showAlert(error: error)
            self.setTitle()
        })
    }
    
    func showAlert(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "При загрузке данных из сети произошла ошибка.\n" + error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setTitle() {
        if let syncTime = dataService.getGroupsSyncTime() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
            let formattedSyncTime = dateFormatter.string(from: syncTime)
            GroupsViewController.groupsTitle = "Группы\nобновлено \(formattedSyncTime)"
            
        } else {
            GroupsViewController.groupsTitle = "Группы"
        }
        DispatchQueue.main.async {
            GroupsViewController.titleLabel.text = GroupsViewController.groupsTitle
            GroupsViewController.titleLabel.sizeToFit()
        }
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        networkLoad(sender: sender)
    }
}
