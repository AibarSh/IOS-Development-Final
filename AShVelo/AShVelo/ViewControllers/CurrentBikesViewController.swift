//
//  CurrentBikesViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 12.12.2025.
//

import UIKit

class CurrentBikesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var savedBicycles: [Bike] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadSavedBikes()
        }
        
    private func loadSavedBikes() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let dataArray = defaults.array(forKey: "SavedBikesObjects") as? [Data] {
            // Decode each Data object back into a Bike struct
            savedBicycles = dataArray.compactMap { data in
                try? decoder.decode(Bike.self, from: data)
            }
        }
        tableView.reloadData()
    }
    
}

extension CurrentBikesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if savedBicycles.isEmpty {
                let label = UILabel()
                label.text = "No saved bikes yet."
                label.textAlignment = .center
                tableView.backgroundView = label
            } else {
                tableView.backgroundView = nil
            }
            return savedBicycles.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath)
        let bike = savedBicycles[indexPath.row]
        
        cell.textLabel?.text = bike.title
        cell.detailTextLabel?.text = bike.manufacturer_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bikeToPreview = savedBicycles[indexPath.row]
        
        performSegue(withIdentifier: "ShowBikePreview", sender: bikeToPreview)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBikePreview",
           let previewVC = segue.destination as? BikePreviewViewController,
           let bike = sender as? Bike {
            previewVC.selectedBike = bike
        }
    }
}

extension CurrentBikesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            savedBicycles.remove(at: indexPath.row)
            let encoder = JSONEncoder()
            let updatedDataArray = savedBicycles.compactMap { try? encoder.encode($0) }
            UserDefaults.standard.set(updatedDataArray, forKey: "SavedBikesObjects")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
