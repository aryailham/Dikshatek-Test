//
//  NewsSourcesRouter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation
import UIKit

final class NewsSourcesRouter {
    static func createModule() -> NewsSourcesViewController {
        // remote
        let remoteDataSource = DefaultNewsRemoteDataSource()
        
        // repository
        let repository = DefaultNewsRepository(remote: remoteDataSource)
        
        // useCase
        let useCase = DefaultGetNewsSourcesUseCase(newsRepository: repository)
        
        // presenter
        let presenter = DefaultNewsSourcesPresenter(router: NewsSourcesRouter(), getNewsSourceUseCase: useCase)
        
        // controller

        let controller = NewsSourcesViewController(nibName: "NewsSourcesViewController", bundle: nil)
        controller.presenter = presenter
        
        return controller
    }
    
    func goToArticlesPage(origin: UIViewController) {
        let controller = ArticlesRouter.createModule()
        origin.navigationController?.pushViewController(controller, animated: true)
    }
}
