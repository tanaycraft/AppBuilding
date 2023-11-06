/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View
{
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var manager: PListManager
    
    @State private var showFavoritesOnly = false
    @State private var topRated = false
    @State var search = ""

    var filteredLandmarks: [Landmark]
    {
        modelData.landmarks.filter
        {
           landmark in
          ((!showFavoritesOnly || landmark.isFavorite) && (!topRated || landmark.rating >= 4))
        }
        
    }

    var body: some View
    {
        
        NavigationView
        {
            
            List
            {
                Button("Save")
                {
                    //create a landmark from the user data
                    //save the lnadmark using the manager
                    
                    /*
                    let latitude = -1234.567
                    let longitude = 1234.567
                    let coordinates: CLLocationCoordinate2D?
                    coordinates?.latitude = latitude
                    coordinates?.longitude = longitude
                    */
                    for landmark in filteredLandmarks
                    {
                        manager.saveLandmark(landmark: landmark)
                    }
                    
                    
                    
                    print(manager.isEmpty())
                    manager.saveLandmark(landmark: filteredLandmarks[1])
                    let data = manager.readPlist()
                    print("Data: \(data)")
                    /*
                    let landmark = Landmark(id: <#T##Int#>, name: <#T##String#>, park: <#T##String#>, state: <#T##String#>, city: <#T##String#>, description: <#T##String#>, isFavorite: <#T##Bool#>, isFeatured: <#T##Bool#>, rating: <#T##Int#>, category: <#T##Landmark.Category#>, imageName: <#T##String#>, image: Image(systemName: "person.fill"), coordinates: coordinates, locationCoordinate: coordinates!)
                    manager.saveLandmark(landmark: landmark)
                    */
                }
                Toggle(isOn: $showFavoritesOnly)
                {
                    Text("Favorites only")
                }
                Toggle(isOn: $topRated)
                {
                    Text("Top Rated only")
                }
                

                ForEach(searchResults, id: \.self)
                {
                    landmark in
                    NavigationLink
                    {
                        LandmarkDetail(landmark: landmark)
                    }
                label:
                    {
                        LandmarkRow(landmark: landmark)
                    }
                }
                 
                /*
                ForEach(filteredLandmarks)
                {
                    landmark in
                    NavigationLink
                    {
                        LandmarkDetail(landmark: landmark)
                    }
                label:
                    {
                        LandmarkRow(landmark: landmark)
                    }
                }
                 */
                 
            }
            .searchable(text: $search)
            .navigationTitle("Landmarks")
            .refreshable {
                
            }
        }
    }
    
    
    var searchResults: [Landmark]
    {
        var searchResults = [Landmark]()
        if search.isEmpty
        {
            return filteredLandmarks
        }
        else
        {
            for i in 0...filteredLandmarks.count-1
            {
                //search.lowercased()
                
                //limited
                if filteredLandmarks[i].name.lowercased().contains(search.lowercased())
                {
                    searchResults.append(filteredLandmarks[i])
                }
            }
        }
        return searchResults
    }
     
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}

