//
//  Item.swift
//  eggplant-brownie
//
//  Created by Márcio Flores on 24/11/20.
//

import UIKit

class Item: NSObject, NSCoding {
    let nome: String
    let calorias: Double
    
    init(_ nome: String, _ calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }
}
