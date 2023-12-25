//
//  WelcomeCoordinator.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 22/12/2023.
//

import UIKit

final class WelcomeCoordinator: Coordinator {
    static let shared = WelcomeCoordinator()
    func start(data: Any?) {
        guard let window = data as? UIWindow else { return }
        let vc = WelcomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
