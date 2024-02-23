//
//  ArticlesPresenter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

protocol ArticlesPresenterInput {
    func getArticles()
    func goToArticle(origin: UIViewController, selectedIndex: Int)
    func fetchNextPage()
}

protocol ArticlesPresenterOutput {
    var articles: Observable<[Article]> { get }
    var errorMessage: Observable<String> { get }
    func getArticlesData() -> [Article]
}

typealias ArticlesPresenter = ArticlesPresenterOutput & ArticlesPresenterInput

final class DefaultArticlesPresenter: ArticlesPresenter {
    let getNewsUseCase: GetNewsUseCase
    let router: ArticlesRouter
    
    let articlesStream = BehaviorRelay<[Article]>(value: [])
    var articles: Observable<[Article]> {
        return articlesStream.asObservable()
    }
    
    let errorMessageStream = PublishSubject<String>()
    var errorMessage: Observable<String> {
        get {
            return errorMessageStream.asObservable()
        }
    }
    
    private var currentPage = 1
    private var selectedSource: String {
        get {
            return NewsFilterHelper.getSource() ?? ""
        }
    }
    
    let disposeBag = DisposeBag()
    
    init(getNewsUseCase: GetNewsUseCase, router: ArticlesRouter) {
        self.getNewsUseCase = getNewsUseCase
        self.router = router
    }

    func getArticles() {
        self.getNewsUseCase
            .execute(page: self.currentPage, source: self.selectedSource)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe { newsResult in
                self.articlesStream.accept(newsResult.articles)
            } onError: { error in
                self.errorMessageStream.onNext(error.getErrorMessageObject().message)
            }.disposed(by: disposeBag)
    }
    
    func fetchNextPage() {
        self.currentPage += 1
        self.getArticles()
    }
    
    func getArticlesData() -> [Article] {
        return self.articlesStream.value
    }
    
    func goToArticle(origin: UIViewController, selectedIndex: Int) {
        let destination = self.articlesStream.value[selectedIndex]
        
        self.router.openNews(origin: origin, articleLink: destination.url)
    }

}
