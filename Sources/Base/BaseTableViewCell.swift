//
//  BaseTableViewCell.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 23/12/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func setupUI() {
        
    }
}
