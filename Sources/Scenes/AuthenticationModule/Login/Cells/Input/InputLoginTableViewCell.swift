//
//  InputLoginTableViewCell.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 23/12/2023.
//

import UIKit

protocol InputLoginTableViewCellProtocol: AnyObject {
    func forgotPassword()
    func login(email: String, password: String)
}

final class InputLoginTableViewCell: BaseTableViewCell {

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var loginButton: UIButton!
    
    private var delegate: InputLoginTableViewCellProtocol?
    
    override func setupUI() {
        super.setupUI()
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        loginButton.setTitle("Login", for: .normal)
        emailTextField.placeholder = "Enter your email"
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
    }
    
    func set(_ delegate: InputLoginTableViewCellProtocol) {
        self.delegate = delegate
    }
    
}

private extension InputLoginTableViewCell {
    @IBAction func forgotPasswordAction(_ sender: Any) {
        delegate?.forgotPassword()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        delegate?.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
