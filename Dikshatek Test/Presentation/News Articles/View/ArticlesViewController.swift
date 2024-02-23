//
//  ArticlesViewController.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import UIKit
import RxSwift

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ArticlesPresenter!
    
    private var dataToRender: [Article] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        presenter.getArticles()
    }
    
    private func bind() {
        self.presenter.articles
            .subscribe(on: MainScheduler.instance)
            .subscribe { _ in
//                self.dataToRender.append(contentsOf: articleToRender)
                
                // count new row insertion
                let articles = self.presenter.getArticlesData()
                var indexPaths = [IndexPath]()
                let startIndex = self.dataToRender.count
                let numOfNewData = articles.count
                
                guard numOfNewData > 0 else { return }
                
                for i in 1...numOfNewData {
                    self.dataToRender.append(articles[i])
                    indexPaths.append(IndexPath(row: startIndex + i - 1, section: 0))
                }

                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .left)
                self.tableView.endUpdates()
            }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        self.title = "News"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.ID)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            presenter.fetchNextPage()
        }
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataToRender.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.ID, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        let dataToShow = self.dataToRender[indexPath.row]
        cell.setData(title: dataToShow.title, author: dataToShow.author)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.presenter.goToArticle(origin: self, selectedIndex: indexPath.row)
    }
}