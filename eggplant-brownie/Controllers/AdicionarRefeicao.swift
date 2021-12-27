//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Márcio Flores on 23/11/20.
//

import UIKit

protocol AdicionarRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class AdicionarRefeicao: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItemDelegate {
    
    // MARK: - Atributos
    
    var delegate: AdicionarRefeicaoDelegate?
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet var itensTableView: UITableView?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        
        itens = ItemDao().load()
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    // MARK: - Métodos tableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        
        celula.textLabel?.text = item.nome
        
        return celula
    }
    
    //MARK: - Métodos tableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        }else {
            celula.accessoryType = .none
            
            let itemClicado = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: itemClicado) {
                itensSelecionados.remove(at: position)
            } else {
                print("O item não existe na lista de itens selecionados")
            }
        }
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text, let felicidadeDaRefeicao = felicidadeTextField?.text else {
            return nil
        }
        
        guard let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar() {
        
        guard let refeicao = recuperaRefeicaoDoFormulario() else {
            Alerta(controller: self).exibe(alertaMessage: "Não foi possível recuperar a refeição e felicidade")
            return
        }
        
        delegate?.add(refeicao)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Métodos
    
    func addItem(_ item: Item) {
        itens.append(item)
        
        ItemDao().save(itens)
        
        guard let tableView = itensTableView else {
            Alerta(controller: self).exibe(alertaMessage: "Não foi possível atualizar a lista de itens")
            return
        }
        
        tableView.reloadData()
    }
}

