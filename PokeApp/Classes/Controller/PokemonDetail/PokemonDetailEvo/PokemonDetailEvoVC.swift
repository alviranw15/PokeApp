//
//  PokemonDetailEvoVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import UIKit

class PokemonDetailEvoVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
  }
  
}

extension PokemonDetailEvoVC {
  
  func setupTableView() {
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
    self.tableView?.register(UINib(nibName: "PokemonEvoCell", bundle: nil), forCellReuseIdentifier: "PokemonEvoCell")
    self.tableView?.rowHeight = UITableView.automaticDimension
    self.tableView?.estimatedRowHeight = UITableView.automaticDimension
  }
  
}

extension PokemonDetailEvoVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
//    return self.pokemonList.count
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return self.pokemonList[section].results?.count ?? 0
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonEvoCell", for: indexPath) as? PokemonEvoCell ?? PokemonEvoCell()
    return cell
  }
  
}
