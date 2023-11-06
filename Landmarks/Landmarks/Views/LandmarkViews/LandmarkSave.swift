//
//  LandmarkSave.swift
//  Landmarks
//
//  Created by Tanay Patil on 12/7/22.
//

import SwiftUI

struct LandmarkSave: View
{
    
    @EnvironmentObject var manager: PListManager
    //@StateObject private var modelData = ModelData()
    @EnvironmentObject var modelData: ModelData
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false


    
    @State private var name : String = ""
    @State private var category : String = ""
    @State private var city : String = ""
    @State private var state : String = ""
    @State private var isFeatured : String = ""
    @State private var isFavorite : String = ""
    @State private var id : String = ""
    @State private var park : String = ""
    @State private var description : String = ""
    
    /*
     rating/coordiantes will be default values
     */
    var body: some View
    {
        /*
         example:
         "name": "Turtle Rock",
         "category": "Rivers",
         "city": "Twentynine Palms",
         "state": "California",
         "id": 1001,
         "isFeatured": true,
         "isFavorite": true,
         "park": "Joshua Tree National Park",
         "coordinates": {
             "longitude": -116.166868,
             "latitude": 34.011286
         },
         "rating": 5,
         "description": "Bordered by the University of California Irvine, Turtle Rock is a residential area home to several parks and golf courses, as well as Concordia University Irvine. The Turtle Rock Trail features the Turtle Rock Outcropping landmark, and city vistas from Turtle Rock Viewpoint. Programs and activities like full moon hikes are popular at Bommer Canyon Nature Trail.",
         */
        NavigationView
        {
            
            /*
            
            List
            {
                TextField("Enter the name", text: $name)
                TextField("Enter the category", text: $category)
                TextField("Enter the city", text: $city)
                TextField("Enter the state", text: $state)
                TextField("Enter the id", text: $id)
                TextField("Is it featured", text: $isFeatured)
                TextField("Is it a favorite", text: $isFavorite)
                TextField("Enter the park", text: $park)
                TextField("Enter the description", text: $description)
                Button("Save")
                {
                    var lm = Landmark(id: 67777, name: name, park: park, state: state, city: city, description: description, isFavorite: true, isFeatured: true, rating: 5, category: Landmark.Category.lakes, imageName: "", image: Image(systemName: "person.fill"), latitude: 12.111, longitude: 12.333)
                    
                    print("Testing")
                    
                    
                    manager.saveLandmark(landmark: lm)
                    modelData.landmarks.append(lm)
                    
                    print (modelData.landmarks.count)
                    
                    print ("added")
                    
                    print (manager.isEmpty())
                    
                }

            }
            .navigationBarTitle(Text("Create a new landmark"))
             
             */
            
            VStack
            {
                Text("Create a new landmark")
                    .font(.title)
                TextField("Enter the name", text: $name)
                TextField("Enter the category", text: $category)
                TextField("Enter the city", text: $city)
                TextField("Enter the state", text: $state)
                TextField("Enter the description", text: $description)
                            
                if selectedImage != nil
                {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                }
                else
                {
                    Image(systemName: "camera.viewfinder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                }
                
                Button("Camera")
                {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }.padding()
                
                Button("Photo") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()
                
                Button("Save")
                {
                    
                    let lm = Landmark(id: 67777, name: name, park: park, state: state, city: city, description: description, isFavorite: true, isFeatured: true, rating: 5, category: Landmark.Category.lakes, imageName: "", image: Image(uiImage: selectedImage!), latitude: 12.111, longitude: 12.333)
                    
                    print("Testing")
                    
                    
                    manager.saveLandmark(landmark: lm)
                    
                    modelData.landmarks.append(lm)
                    
                    print (modelData.landmarks.count)
                    
                    print ("added")
                    
                    print (manager.isEmpty())
                    
                }
                 
            }
            
            //.navigationBarTitle(Text("Create a new landmark"))
            .sheet(isPresented: self.$isImagePickerDisplay)
            {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
        }
    
        }
    }


struct LandmarkSave_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkSave()
    }
}
