//
//  TopRatedButton.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/31/22.
//

import SwiftUI

struct TopRatedButton: View
{
    @Binding var isSet: Bool

    var body: some View
    {
        Button
        {
            isSet.toggle()
        } label:
        {
            Label("Toggle Top Rated", systemImage: isSet ? "checkmark.seal.fill" : "checkmark.seal")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .green : .gray)
        }
    }
}

struct TopRatedButton_Previews: PreviewProvider
{
    static var previews: some View
    {
        TopRatedButton(isSet: .constant(true))
    }
}
