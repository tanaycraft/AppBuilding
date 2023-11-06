//
//  StarRatingView.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/27/22.
//



import SwiftUI

struct RatingView: View
{
    var rating: Int

    var label = ""
    var maximumRating = 5

    var offImage: Image?
    var fullStar = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View
    {
        HStack
        {
            if label.isEmpty == false
            {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self)
            {
                number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > rating
        {
            return offImage ?? fullStar
        }
        else
        {
            return fullStar
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View
    {
        RatingView(rating: Int(2))
    }
}
