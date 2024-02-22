//
//  GetNewsUseCase.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation
import RxSwift

protocol GetNewsUseCase {
    func execute(page: Int, source: String) -> Observable<NewsResult>
}

final class DefaultGetNewsUseCase: GetNewsUseCase {
    let newsRepository: NewsRepository
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func execute(page: Int, source: String) -> Observable<NewsResult> {
        return newsRepository.getNews(page: page, source: source)
    }
}

