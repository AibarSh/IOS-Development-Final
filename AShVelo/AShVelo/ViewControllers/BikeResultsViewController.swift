//
//  BikeResultsViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 14.12.2025.
//

import UIKit

class BikeResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var searchQuery: String = ""
    var bikes: [Bike] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Matching Bikes"
        tableView.dataSource = self
        tableView.delegate = self
        
        spinner.hidesWhenStopped = true
        
        fetchBikes()
    }
    
    func fetchBikes() {
        
        spinner.startAnimating()
        
        guard let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://bikeindex.org/api/v3/search?query=\(encodedQuery)&location=IP&distance=10&stolenness=all") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
  
                
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(BikeResponse.self, from: data)
                    self?.bikes = decodedResponse.bikes
                    self?.tableView.reloadData()
                } catch {
                    print("JSON Decoding error: \(error)")
                }
            }
        }.resume()
    }
}

extension BikeResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bikes.isEmpty && !spinner.isAnimating {
            let emptyLabel = UILabel()
            emptyLabel.text = "No bikes found with these components."
            emptyLabel.textAlignment = .center
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        return bikes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath)
        let bike = bikes[indexPath.row]
        
        cell.textLabel?.text = bike.title
        cell.detailTextLabel?.text = "\(bike.manufacturer_name) • \(bike.year ?? 0)"
        

        if let imageUrlString = bike.display_image, let url = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                }
            }
        } else {
            cell.imageView?.image = UIImage(systemName: "bicycle")
        }
        
        return cell
    }
}

extension BikeResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let saveAction = UIContextualAction(style: .normal, title: "Save") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            let selectedBike = self.bikes[indexPath.row]
            self.saveBikeToFavorites(bike: selectedBike)

            let alert = UIAlertController(title: "Saved!", message: "\(selectedBike.title) added to favorites.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            
            completionHandler(true)
        }
        
        saveAction.backgroundColor = .systemGreen
        saveAction.image = UIImage(systemName: "heart.fill")
        
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bikeToPreview = bikes[indexPath.row]
            performSegue(withIdentifier: "ShowBikePreview", sender: bikeToPreview)
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBikePreview",
           let previewVC = segue.destination as? BikePreviewViewController,
           let bike = sender as? Bike {
            previewVC.selectedBike = bike
        }
    }
    
    private func saveBikeToFavorites(bike: Bike) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        var savedBikesData = defaults.array(forKey: "SavedBikesObjects") as? [Data] ?? []
        
        if let encoded = try? encoder.encode(bike) {
            
            let alreadySaved = savedBikesData.contains { data in
                if let decoded = try? JSONDecoder().decode(Bike.self, from: data) {
                    return decoded.id == bike.id
                }
                return false
            }
            
            if !alreadySaved {
                savedBikesData.append(encoded)
                defaults.set(savedBikesData, forKey: "SavedBikesObjects")
            }
        }
    }
}
