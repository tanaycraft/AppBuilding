//
//  PListManager.swift
//  Landmarks
//
//
//  Created by Tanay Patil on 11/14/22.
//
//https://developer.apple.com/tutorials/sample-apps/capturingphotos-captureandsave

import UIKit

class PListManager: ObservableObject
{
    let namePlist = "landmarksData"
    let key = "Results"
    
    
    //create a path
    private func createPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentsDirectory = paths.object(at: 0) as! NSString
        
        let path = documentsDirectory.appendingPathComponent(namePlist + ".plist")
        return path
        
    }
    
    //write
    private func writePList(data: NSMutableDictionary)
    {
        let path = self.createPath()
        
        do
        {
            try data.write(toFile: path, atomically: true)
        }
        catch
        {
            print("ERROR")
        }
    }
    
    //read
    public func readPlist() -> NSMutableDictionary
    {
        let path = self.createPath()
        
        if let output = NSMutableDictionary(contentsOfFile: path)
        {
            return output
        }
        
        return NSMutableDictionary()
    }
    
    //isEmpty
    public func isEmpty() -> (Bool, NSMutableDictionary)
    {
        let savedData = self.readPlist()
        if(savedData.count == 0)
        {
            return (true, savedData)
        }
        return(false, savedData)
    }
    
    //convert the struct to an object for a landmark
    public func createLandmarkDictionary(landmark: Landmark) -> NSMutableDictionary
    {
        let id = UUID()
        
        return ["name": landmark.name,
                "park": landmark.park,
                "category": landmark.category.rawValue,
                "id": landmark.id,
                "state": landmark.state,
                "city": landmark.city,
                "imageName": landmark.imageName,
                "image": landmark.image,
                "isFeatured": landmark.isFeatured,
                "isFavorite": landmark.isFavorite,
                "rating": landmark.rating,
                "latiude": landmark.locationCoordinate.latitude,
                "longitude": landmark.locationCoordinate.longitude]
    }
    
    //contains
    public func contains(landmarks: [NSMutableDictionary], landmarkToSave: Landmark) -> Bool
    {
        for landmark in landmarks
        {
            let id = landmark.object(forKey: "id") as! Int
            if id == landmarkToSave.id
            {
                return true
            }
        }
        return false
    }
    
    //clear -  delete all the data
    //Do not call this unless you actually want to delete all the data!
    public func clearPlist()
    {
        let landmarks = [NSMutableDictionary]()
        
        let data = ["Results": ["count": 0, "landmarks": landmarks]] as NSMutableDictionary
        
        //self.writePList(data: data)
    }
    
    //save a landmark
    public func saveLandmark(landmark: Landmark)
    {
        var currentLandmarkArray: NSMutableArray = NSMutableArray()
        let landmarkDictionary = self.createLandmarkDictionary(landmark: landmark)
        let readResult = self.isEmpty()
        
        if readResult.0
        {
            currentLandmarkArray = [landmarkDictionary]
            currentLandmarkArray.add(landmarkDictionary)
        }
        else
        {
            let completeDictionary = readResult.1.object(forKey: "Results") as! NSMutableDictionary
            currentLandmarkArray = completeDictionary.object(forKey: "landmarks") as! NSMutableArray
            var set = Set(currentLandmarkArray as! [NSMutableDictionary])
            set.insert(landmarkDictionary)
            
            currentLandmarkArray.removeAllObjects()
            
            for object in set
            {
                currentLandmarkArray.add(object)
            }
        }
        let data = ["Results": ["count": currentLandmarkArray.count, "landmarks": currentLandmarkArray]] as NSMutableDictionary
        
        self.writePList(data: data)
        
    }
    
}


