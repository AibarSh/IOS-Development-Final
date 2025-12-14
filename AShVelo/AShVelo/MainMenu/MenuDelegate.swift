//
//  to.swift
//  AShVelo
//
//  Created by Macbook Air on 13.12.2025.
//


// MenuCell.swift

import UIKit

// Define a protocol to communicate button taps back to the ViewController
protocol MenuCellDelegate: AnyObject {
    func menuCellDidTapButton(cell: MenuCell, itemTitle: String)
}

class MenuCell: UITableViewCell {

    // 1. You must connect the button from your Storyboard to this Outlet
    @IBOutlet weak var actionButton: UIButton!
    
    // 2. Add properties to hold the data and the delegate
    weak var delegate: MenuCellDelegate?
    var itemTitle: String?

    // 3. Connect the button from your Storyboard to this Action
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        // When the button is tapped, notify the delegate (the ViewController)
        if let title = itemTitle {
            delegate?.menuCellDidTapButton(cell: self, itemTitle: title)
        }
    }
}