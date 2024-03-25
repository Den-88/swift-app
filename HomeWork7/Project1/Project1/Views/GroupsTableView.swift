//
//  GroupsTableView.swift
//  Project1
//
//  Created by Денис Шакуров on 25.03.2024.
//

import UIKit

class GroupsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private var models: [Groups] = []
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        register(GroupsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setGroups(_ groups: [Groups]) {
        DispatchQueue.main.async { [weak self] in
            self?.models = groups
            self?.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let groupCell = cell as? GroupsCustomTableViewCell else {
            return UITableViewCell()
        }
        let group = models[indexPath.row]
        groupCell.setupGroups(group: group)
        return groupCell
    }
}
