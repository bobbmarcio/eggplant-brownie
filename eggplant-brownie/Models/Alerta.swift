//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Márcio Flores on 26/12/21.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(alertaTitle: String = "Desculpe", alertaMessage: String, alertaAction: String = "Ok") {
        let alerta = UIAlertController(title: alertaTitle, message: alertaMessage, preferredStyle: .alert)
        let botão = UIAlertAction(title: alertaAction, style: .cancel, handler: nil)
        alerta.addAction(botão)
        controller.present(alerta, animated: true, completion: nil)
    }
}
