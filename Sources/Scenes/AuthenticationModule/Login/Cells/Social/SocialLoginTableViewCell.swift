//
//  SocialLoginTableViewCell.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 23/12/2023.
//

import UIKit

protocol SocialLoginTableViewCellProtocol: AnyObject {
    func facebookLogin()
    func googleLogin()
    func appleLogin()
}

final class SocialLoginTableViewCell: BaseTableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var facebookButton: UIButton!
    @IBOutlet private var googleButton: UIButton!
    @IBOutlet private var appleButton: UIButton!
    
    private var delegate: SocialLoginTableViewCellProtocol?
    
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "Or Login with"
        facebookButton.setImage(Asset.AssetsIOS.iconFacebook.image, for: .normal)
        googleButton.setImage(Asset.AssetsIOS.iconGoogle.image, for: .normal)
        appleButton.setImage(Asset.AssetsIOS.iconApple.image, for: .normal)
        
        [facebookButton, googleButton, appleButton].forEach {
            $0?.setTitle("", for: .normal);
        }
    }
    
    func set(_ delegate: SocialLoginTableViewCellProtocol) {
        self.delegate = delegate
    }
    
}

private extension SocialLoginTableViewCell {
    @IBAction func facebookLoginAction(_ sender: Any) {
        delegate?.facebookLogin()
    }
    
    @IBAction func googleLoginAction(_ sender: Any) {
        delegate?.googleLogin()
    }
    
    @IBAction func appleLoginAction(_ sender: Any) {
        delegate?.appleLogin()
    }
}
