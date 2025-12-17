//
//  BikePreviewViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 17.12.2025.
//


import UIKit

class BikePreviewViewController: UIViewController {

    @IBOutlet weak var bikeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    var selectedBike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard let bike = selectedBike else { return }
        
        self.title = "Bike Details"
        titleLabel.text = bike.title
        manufacturerLabel.text = "Manufacturer: \(bike.manufacturer_name)"
        yearLabel.text = "Year: \(bike.year ?? 0)"
        frameLabel.text = "Model/Frame: \(bike.frame_model ?? "Unknown")"

        
        statusLabel.text = bike.stolen ? "⚠️ Reported Stolen" : "✅ Status Clear"
        statusLabel.textColor = bike.stolen ? .systemRed : .systemGreen

        if let imageUrlString = bike.display_image, let url = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.bikeImageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            bikeImageView.image = UIImage(systemName: "bicycle")
        }
    }
}
