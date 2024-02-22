//
//  NewsCategoriesViewController.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import UIKit

enum NewsCategories {
    case all
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

final class NewsCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsCategoriesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.title = "Categories"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SingleTextTableViewCell.nib, forCellReuseIdentifier: SingleTextTableViewCell.ID)
    }
}

extension NewsCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleTextTableViewCell.ID, for: indexPath) as? SingleTextTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = String(describing: self.presenter.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.goToNewsSourcesPage(selectedIndex: indexPath.row)
    }
}
