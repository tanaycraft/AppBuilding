//
//  ContentView.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/17/22.
//

import SwiftUI

struct ContentView: View
{


    enum Tab
    {
        case featured
        case list
        case save
    }

    var body: some View
    {
        TabView()
        {
            CategoryHome()
                .tabItem
                {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)

            LandmarkList()
                .tabItem
                {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            //New Tab Item
            LandmarkSave()
                .tabItem
            {
                Label("Save", systemImage: "suit.heart.fill")
                    .tag(Tab.save)

            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
            .environmentObject(ModelData())
    }
}
