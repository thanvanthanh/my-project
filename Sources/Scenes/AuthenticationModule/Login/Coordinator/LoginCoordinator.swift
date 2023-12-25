//
//  LoginCoordinator.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 23/12/2023.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    static let shared = LoginCoordinator()
    
    func start(data: Any?) {
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel(loginUseCases: LoginRequest())
        vc.getRootViewController().navigationController?.pushViewController(vc, animated: true)
    }
}
