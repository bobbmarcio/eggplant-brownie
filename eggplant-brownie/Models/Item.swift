//
//  Item.swift
//  eggplant-brownie
//
//  Created by Márcio Flores on 24/11/20.
//

import UIKit

class Item: NSObject {
    let nome: String
    let calorias: Double
    
    init(_ nome: String, _ calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
