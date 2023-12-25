//
//  TitleLoginTableViewCell.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 23/12/2023.
//

import UIKit

protocol TitleLoginTableViewCellProtocol: AnyObject {
    func backAction()
}

final class TitleLoginTableViewCell: BaseTableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    
    private var delegate: TitleLoginTableViewCellProtocol?
    
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "Welcome back! Glad to see you, Again!"
    }
    
    func set(_ delegate: TitleLoginTableViewCellProtocol) {
        self.delegate = delegate
    }
    
}

private extension TitleLoginTableViewCell {
    @IBAction func backAction(_ sender: Any) {
        delegate?.backAction()
    }
}
