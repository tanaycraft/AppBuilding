//
//  Data.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/19/22.
//


import Foundation
import Combine

final class ModelData: ObservableObject
{
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default

    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    /*
    func loadPList() -> [Landmark]
    {
        var landmarks = [Landmark]()
        let manager = PListManager()
        let data: NSMutableDictionary = manager.readPlist()
        print(data)
        
        let keys = data.allKeys
        print("This is all the key: \(keys)")
        
        let actualData: NSMutableDictionary =  data.object(forKey: "Results") as! NSMutableDictionary
        
        print("This is the actual data: ", actualData)
        
        let actualKeys = actualData.allKeys
        print("These are the actual keys: \(actualKeys)")
        
        let actualLandmarks: NSMutableArray = actualData.object(forKey: "landmarks") as! NSMutableArray
        print("These are the actual saved landmarks in the plist: ", actualLandmarks)
        
        for dictionary in actualLandmarks
        {
            let dic = dictionary as! NSMutableDictionary
            let id = dic.object(forKey: "id") as! Int
            let name = dic.object(forKey: "name") as! String
            let category = dic.object(forKey: "category") as! String
            let park = dic.object(forKey: "park") as! String
            let city = dic.object(forKey: "city") as! String
            let description = dic.object(forKey: "description") as! String
            let state = dic.object(forKey: "park") as! String
        
        }
        
        for i in 0...actualLandmarks.count-1
        {
            let dic: NSMutableDictionary = actualLandmarks[i] as! NSMutableDictionary
            print(dic.object(forKey: "city"))
            let name = dic.object(forKey: "name") as! String
            
            /*
            let landmark = Landmark(id: id, name: name, park: park, state: state, city: city, description: description, isFavorite: <#T##Bool#>, isFeatured: <#T##Bool#>, rating: <#T##Int#>, category: <#T##Landmark.Category#>, imageName: <#T##String#>, image: <#Image#>, latitude: <#T##Double#>, longitude: <#T##Double#>)
            landmarks.append(landmark)
            
            */
        }

        //make sure that you create a Plist manager
        //call readPlist
        //extract the landmarks
        //create an array of landmarks
        //return this array
        
        return landmarks
        
    }
     */
    func loadPlist <T: Decodable> (_ filename: String) -> T
    {
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else
        {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        var landmarkArray: [Landmark] = []
        if let data = try? Data(contentsOf: file)
        {
            let decoder = PropertyListDecoder()
            landmarkArray = try! decoder.decode([Landmark].self, from: data)
        }
        print(landmarkArray)
        return landmarkArray as! T
    }
    
    
}

func load<T: Decodable>(_ filename: String) -> T
{
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


