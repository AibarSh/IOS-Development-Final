//
//  BikePartsViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 12.12.2025.
//

import UIKit

class BikePartsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    let componentCategories = ["Frame", "Suspension", "Wheels", "Groupset", "Hubs"]
    
    var selectedComponents: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Build Your Search"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func resetSearchTapped(_ sender: UIBarButtonItem) {
        selectedComponents.removeAll()
        tableView.reloadData()
    }
    @IBAction func checkBikesButtonTapped(_ sender: UIButton) {

        let queryParts = selectedComponents.values.joined(separator: " ")

        if queryParts.isEmpty {
            let alert = UIAlertController(title: "Selection Needed", message: "Please select at least one component to search.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        performSegue(withIdentifier: "ShowBikeResults", sender: queryParts)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ShowComponentPicker",
           let pickerVC = segue.destination as? ComponentPickerViewController,
           let category = sender as? String {
            
            pickerVC.categoryTitle = category
            pickerVC.delegate = self
        }
        
        if segue.identifier == "ShowBikeResults",
           let resultsVC = segue.destination as? BikeResultsViewController,
           let searchQuery = sender as? String {
            resultsVC.searchQuery = searchQuery
        }
    }
}

// TableView Logic
extension BikePartsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return componentCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell", for: indexPath)
        let category = componentCategories[indexPath.row]
        
        cell.textLabel?.text = category
        cell.textLabel?.font = .systemFont(ofSize: 20)
        
        if let selectedPart = selectedComponents[category] {
            cell.detailTextLabel?.text = selectedPart
            cell.detailTextLabel?.textColor = .systemBlue
            cell.detailTextLabel?.font = .systemFont(ofSize: 20)
        } else {
            cell.detailTextLabel?.text = "Select Part"
            cell.detailTextLabel?.textColor = .lightGray
            cell.detailTextLabel?.font = .systemFont(ofSize: 20)
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCategory = componentCategories[indexPath.row]
        performSegue(withIdentifier: "ShowComponentPicker", sender: selectedCategory)
    }
    
}

extension BikePartsViewController: ComponentPickerDelegate {
    func didSelectComponent(_ part: String, for category: String) {
        
        selectedComponents[category] = part        
        tableView.reloadData()
    }
}
