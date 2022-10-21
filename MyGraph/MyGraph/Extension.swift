//
//  Extension.swift
//  MyGraph
//
//  Created by slareau on 2022-10-17.
//

import Foundation


extension String{
    
    func toCurrencyFormat() -> String {
        if let DoubleV = Double(self){
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = NumberFormatter.Style.currency
            currencyFormatter.locale = Locale(identifier: "fr_CA")/* Using Nigeria's Naira here or you can use Locale.current to get current locale, please change to your locale, link below to get all locale identifier.*/
            //  return currencyFormatter.string(from: NSNumber(value: DoubleV)) ?? ""
            return currencyFormatter.string(for: DoubleV) ?? ""
        }
        return ""
    }
}
