//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/25/22.
//

import SwiftUI

struct FavoriteButton: View
{
    @Binding var isSet: Bool

    var body: some View
    {
        Button
        {
            isSet.toggle()
        } label:
        {
            Label("Toggle Favorite", systemImage: isSet ? "bookmark.fill" : "bookmark")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .blue : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider
{
    static var previews: some View
    {
        FavoriteButton(isSet: .constant(true))
    }
}
