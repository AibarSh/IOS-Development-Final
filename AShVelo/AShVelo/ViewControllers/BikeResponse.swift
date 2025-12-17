//
//  BikeResponse.swift
//  AShVelo
//
//  Created by Macbook Air on 16.12.2025.
//


import Foundation

struct BikeResponse: Codable {
    let bikes: [Bike]
}

struct Bike: Codable {
    let id: Int
    let title: String
    let manufacturer_name: String
    let frame_model: String?
    let display_image: String? 
    let year: Int?
    
    let stolen: Bool
}
