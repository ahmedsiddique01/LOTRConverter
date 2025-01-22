//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Ahmed Siddique on 09/01/2025.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency:Currency = .silverPenny
    @State var rightCurrency:Currency = .goldPiece
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height:200)
                //text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
                
                HStack{
                    VStack
                    {
                        HStack{
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }.padding(.bottom, -5)
                            .onTapGesture {
                                showSelectCurrency.toggle()
                                currencyTip.invalidate(reason: .actionPerformed)
                            }
                            .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        TextField("Amount", text: $leftAmount).textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            
                }
                    Image(systemName:"equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    VStack{
                        HStack
                        {
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            
                        }.padding(.bottom, -5).onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        
                        TextField("Amount", text: $rightAmount).textFieldStyle(.roundedBorder).multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }.padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 20))
                    .keyboardType(.decimalPad)
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
        }
        .task{
            try? Tips.configure()
        }
        .onChange(of: leftCurrency){
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency){
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .onChange(of: leftAmount){
            if leftTyping == true {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount){
            if rightTyping == true{
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .sheet(isPresented: $showExchangeInfo){
            ExchangeInfo()
        }.sheet(isPresented: $showSelectCurrency){
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}
