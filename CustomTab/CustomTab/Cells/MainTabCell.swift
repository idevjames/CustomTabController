//
//  MainTabCell.swift
//  CustomTab
//
//  Created by HooGi on 2021/10/29.
//

import UIKit

class MainTabCell: UICollectionViewCell {
    // MARK: - Constant
    static let identifier = "MainTabCell"

    // MARK: - UI Components
    @IBOutlet weak var tabLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - Methods
    public func configure(title: String?) {
        tabLabel.text = title ?? ""
    }
    
    public func fittingSize(availableHeight: CGFloat, title: String?) -> CGSize {
        let cell = MainTabCell()
        cell.configure(title: title)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
