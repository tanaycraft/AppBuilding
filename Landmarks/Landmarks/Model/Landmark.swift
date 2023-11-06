

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable
{
    var id: Int
    var name: String
    var park: String
    var state: String
    var city: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var rating: Int
    
    var category: Category
    
    enum Category: String, CaseIterable, Codable
    {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    var imageName: String
    var image: Image
    {
        
        Image(imageName)
    }

        private var coordinates: Coordinates
        var locationCoordinate: CLLocationCoordinate2D
        {
            CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude)
        }
    
    init(id: Int, name: String, park: String, state: String, city: String, description: String, isFavorite: Bool, isFeatured: Bool, rating: Int, category: Category, imageName: String, image: Image, latitude: Double, longitude: Double)
    {
        self.id = id
        self.name = name
        self.park = park
        self.state = state
        self.city = city
        self.description = description
        self.isFavorite = isFavorite
        self.isFeatured = isFeatured
        self.rating = rating
        self.category = category
        self.imageName = imageName
        self.coordinates = Coordinates(latitude: 0, longitude: 0)
        self.coordinates.latitude = latitude
        self.coordinates.latitude = latitude
    }

        
}


