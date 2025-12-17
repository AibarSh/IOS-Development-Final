//
//  ComponentPickerViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 16.12.2025.
//

import UIKit

protocol ComponentPickerDelegate: AnyObject {
    func didSelectComponent(_ part: String, for category: String)
}

class ComponentPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ComponentPickerDelegate?
    var categoryTitle: String = ""
    
    let partOptions: [String: [String]] = [
        "Frame": ["Specialized", "Santa Cruz", "Trek", "Giant", "Canyon", "Cannondale", "Cervélo", "Merida", "Nishiki", "Marlin", "Mongoose", "Zephyr", "Schwinn", "Rockrider"],
        "Suspension": ["Fox", "RockShox", "Suntour", "Ohlins"],
        "Wheels": ["DT Swiss", "Reserve", "Mavic", "Enve", "Hunt"],
        "Groupset": ["Shimano", "Shimano Altus", "Shimano Acero", "Shimano Alivio","Shimano Deore", "Shimano SLX","Shimano XT", "Shimano XTR", "SRAM","SRAM GX", "SRAM XO1", "SRAM Eagle"],
        "Hubs": ["Chris King", "Hope Pro 4", "Industry Nine", "DT Swiss 350"]
    ]
    
    var currentOptions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select \(categoryTitle)"
        currentOptions = partOptions[categoryTitle] ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// TableView
extension ComponentPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartCell", for: indexPath)
        cell.textLabel?.text = currentOptions[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPart = currentOptions[indexPath.row]
 
        delegate?.didSelectComponent(selectedPart, for: categoryTitle)

        navigationController?.popViewController(animated: true)
    }
}
