//
//  WelcomeViewController.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 22/12/2023.
//

import UIKit

final
class WelcomeViewController: BaseViewController {

    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var registerButton: UIButton!
    
    override func setupUI() {
        super.setupUI()
        backgroundImage.image = Asset.AssetsIOS.welcome.image
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
    }
    
}

private extension WelcomeViewController {
    @IBAction func loginAction(_ sender: Any) {
        LoginCoordinator.shared.start(data: nil)
    }
    
    @IBAction func registerAction(_ sender: Any) {
    }
}
