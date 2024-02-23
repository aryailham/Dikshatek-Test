//
//  ArticlesRouter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation
import UIKit

final class ArticlesRouter {
    static func createModule() -> ArticlesViewController {
        // remote
        let remoteDataSource = DefaultNewsRemoteDataSource()
        
        // repository
        let repository = DefaultNewsRepository(remote: remoteDataSource)
        
        // useCase
        let useCase = DefaultGetNewsUseCase(newsRepository: repository)
        
        // presenter
        let presenter = DefaultArticlesPresenter(getNewsUseCase: useCase, router: ArticlesRouter())
        
        // controller
        let controller = ArticlesViewController(nibName: "ArticlesViewController", bundle: nil)
        controller.presenter = presenter
        
        return controller
    }
    
    func openNews(origin: UIViewController, articleLink: String) {
        let controller = WebViewController.createModule(destination: articleLink)
        origin.show(controller, sender: nil)
    }

}
