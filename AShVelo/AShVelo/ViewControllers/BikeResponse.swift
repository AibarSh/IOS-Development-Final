import Foundation

struct BikeResponse: Codable {
    let bikes: [Bike]
}

struct Bike: Codable {
    let id: Int
    let title: String
    let manufacturer_name: String
    let frame_model: String?
    let display_image: String? // URL for the bike photo
    let year: Int?
    
    // Bike Index uses "stolen" status, we can show if it's safe or not
    let stolen: Bool
}