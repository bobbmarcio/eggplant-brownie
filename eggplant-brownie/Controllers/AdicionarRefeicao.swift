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
    var itens: [Item] = [Item("Molho de tomate", 40.0),
                         Item("Queijo", 40.0),
                         Item("Molho Apimentado", 40.0),
                         Item("Manjericão", 40.0)]
    var itensSelecionados: [Item] = []
    
    // MARK - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet var itensTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
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
    
    // MARK: - IBActions
    
    @IBAction func adicionar() {
        
        guard let nomeDaRefeicao = nomeTextField?.text, let felicidadeDaRefeicao = felicidadeTextField?.text else {
            print("A refeicão deve possuir um nome e felicidade.")
            return
        }
        
        guard let felicidade = Int(felicidadeDaRefeicao) else {
            print("A felicidade da refeicão deve ser um número.")
            return
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        print("Comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")
        
        delegate?.add(refeicao)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Métodos
    
    func addItem(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
    }
}

