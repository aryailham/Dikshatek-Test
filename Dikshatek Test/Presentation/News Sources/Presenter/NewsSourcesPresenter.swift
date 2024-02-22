//
//  NewsSourcesPresenter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

protocol NewsSourcesPresenterInput {
    func getNewsSources()
    func goToArticlesPage(origin: UIViewController, selectedIndex: Int)
}

protocol NewsSourcesPresenterOutput {
    var sources: Observable<[NewsSource]> { get }
}

typealias NewsSourcesPresenter = NewsSourcesPresenterInput & NewsSourcesPresenterOutput

final class DefaultNewsSourcesPresenter: NewsSourcesPresenter {
    let router: NewsSourcesRouter
    let getNewsSourceUseCase: GetNewsSourcesUseCase
    
    let sourcesStream = BehaviorRelay<[NewsSource]>(value: [])
    var sources: Observable<[NewsSource]> {
        get {
            return sourcesStream.asObservable()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    init(router: NewsSourcesRouter, getNewsSourceUseCase: GetNewsSourcesUseCase) {
        self.router = router
        self.getNewsSourceUseCase = getNewsSourceUseCase
    }
    
    func getNewsSources() {
        guard let savedCategory = NewsFilterHelper.getCategory() else {
            return
        }
        
        self.getNewsSourceUseCase.execute(category: savedCategory != "all" ? savedCategory : nil)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observe(on: MainScheduler.instance)
            .subscribe { newsSourceResult in
                self.sourcesStream.accept(newsSourceResult.sources)
            }.disposed(by: disposeBag)
    }
    
    func goToArticlesPage(origin: UIViewController, selectedIndex: Int) {
        let selectedSource = self.sourcesStream.value[selectedIndex].name
        
        self.router.goToArticlesPage(origin: origin)
    }
    
    private func saveSelectedSource(selectedSource: String) {
        NewsFilterHelper.setSource(source: selectedSource)
    }
}
