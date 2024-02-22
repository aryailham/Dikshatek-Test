//
//  NewsCategoriesRouter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation
import UIKit

final class NewsCategoriesRouter {
    static func createModule() -> NewsCategoriesViewController {
        // router
        let router = NewsCategoriesRouter()
        
        // presenter
        let presenter = DefaultNewsCategoriesPresenter(router: router)
        
        let controller = NewsCategoriesViewController(nibName: "NewsCategoriesViewController", bundle: nil)
        controller.presenter = presenter
        
        return controller
    }
    
    func goToNewsSourcesPage(origin: UIViewController) {
        let destination = NewsSourcesRouter.createModule()
        origin.navigationController?.pushViewController(destination, animated: true)
    }
}
