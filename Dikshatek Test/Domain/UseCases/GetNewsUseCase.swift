//
//  GetNewsUseCase.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation
import RxSwift

protocol GetNewsUseCase {
    func execute() -> Observable<NewsResult>
}

final class DefaultGetNewsUseCase: GetNewsUseCase {
    let newsRepository: NewsRepository
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func execute() -> Observable<NewsResult> {
        return newsRepository.getNews()
    }
}

