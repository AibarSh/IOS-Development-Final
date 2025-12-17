//
//  ViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 08.12.2025.
//

import UIKit

class ViewController: UIViewController, MenuCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let menuItems = [
        "Search Bikes By Component",
        "Current Bikes",
        "Guidelines",
        "Watch more"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    
    
    func menuCellDidTapButton(cell: MenuCell, itemTitle: String) {
            
            switch itemTitle {
            case "Search Bikes By Component":
                performSegue(withIdentifier: "ShowComponentSearch", sender: nil)
            case "Current Bikes":
                performSegue(withIdentifier: "ShowCurrentBikes", sender: nil)
            case "Guidelines":
                openURL("https://www.bike24.com/advice/buyers-guides/how-to-choose-a-bike?referrer=https%3A%2F%2Fwww.google.com%2F")
            case "Watch more":
                openURL("https://www.youtube.com/@gmbn")
            default:
                break
            }
        }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier: String
        switch indexPath.row {
        case 0: identifier = "SearchBike"
        case 1: identifier = "CurrentBikes"
        case 2: identifier = "Guidelines"
        case 3: identifier = "WatchMore"
        default: identifier = "SearchBike"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MenuCell
        cell.delegate = self
        cell.itemTitle = menuItems[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menuItems[indexPath.row]
        print("Tapped: \(selectedItem)")
        
        // 4. Navigation logic placeholder
        switch selectedItem {
        case "Search Bikes By Component":
            print("Navigating to Component Search...")
            break
        case "Current Bikes":
            print("Navigating to Current Bikes...")
            break
        default:
            break
        }
    }

}
