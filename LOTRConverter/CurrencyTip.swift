//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Ahmed Siddique on 22/01/2025.
//


import TipKit

struct CurrencyTip: Tip {
    var title: Text = Text("Change Currency")
    var message:Text? = Text("You can tap the left or right currency icon to bring up the Select Currency screen.")
    var image: Image? = Image(systemName: "hand.tap.fill")
}
