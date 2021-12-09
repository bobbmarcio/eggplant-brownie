//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Márcio Flores on 29/11/20.
//

import UIKit

protocol AdicionarItemDelegate {
    func addItem(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var caloriasTextField: UITextField?
    
    // MARK: - Atributos
    
    var delegate: AdicionarItemDelegate?
    
    init(delegate: AdicionarItemDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nome = nomeTextField?.text, let calorias = caloriasTextField?.text else { return }
        
        guard let numeroDeCalorias = Double(calorias) else { return }
        
        let item = Item(nome, numeroDeCalorias)
                
        delegate?.addItem(item)
        
        navigationController?.popViewController(animated: true)
    }
    
}
