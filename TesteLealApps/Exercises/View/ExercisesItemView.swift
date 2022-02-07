//
//  ExercisesItemView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 12/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExercisesItemView: View {
    
    var item: Exercises
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: item.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .cornerRadius(15)
            HStack(spacing: 8){
                
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            
            HStack{
                Text(item.observacoes)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}
