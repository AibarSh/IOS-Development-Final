//
//  MenuDelegate.swift
//  AShVelo
//
//  Created by Macbook Air on 13.12.2025.
//


// MenuCell.swift

import UIKit

protocol MenuCellDelegate: AnyObject {
    func menuCellDidTapButton(cell: MenuCell, itemTitle: String)
}

class MenuCell: UITableViewCell {

    @IBOutlet weak var actionButton: UIButton!
    
    weak var delegate: MenuCellDelegate?
    var itemTitle: String?

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if let title = itemTitle {
            delegate?.menuCellDidTapButton(cell: self, itemTitle: title)
        }
    }
}
