//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Ahmed Siddique on 09/01/2025.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let rightImage: ImageResource
    let text: String
    
    var body: some View {
        HStack{
            Image(leftImage).resizable().scaledToFit().frame(height: 33)
            Text(text)
            Image(rightImage).resizable().scaledToFit().frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpenny, rightImage: .goldpiece, text: "Hello")
}

