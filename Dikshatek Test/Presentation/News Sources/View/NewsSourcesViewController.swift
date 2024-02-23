//
//  NewsSourcesViewController.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import UIKit
import RxSwift

class NewsSourcesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsSourcesPresenter!

    private let disposeBag = DisposeBag()
    
    private var dataToRender: [NewsSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.setupView()
        self.presenter.getNewsSources()
    }

    private func bind() {
        self.presenter.sources
            .observe(on: MainScheduler.instance)
            .subscribe { sources in
                self.dataToRender = sources
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        self.title = "Sources"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SingleTextTableViewCell.nib, forCellReuseIdentifier: SingleTextTableViewCell.ID)
    }

}

extension NewsSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataToRender.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleTextTableViewCell.ID, for: indexPath) as? SingleTextTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = self.dataToRender[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.presenter.goToArticlesPage(origin: self, selectedIndex: indexPath.row)
    }
}
