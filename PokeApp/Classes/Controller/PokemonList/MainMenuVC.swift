//
//  MainMenuVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 17/08/21.
//

import UIKit
import SDWebImage

class MainMenuVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var pokemonList: [DAOPokemonListBaseClass] = []
  var pokemonTemporary: DAOPokemonListBaseClass?
  
  var successCount = 0
  var apiFailed: [DAOPokemonListResults] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Pokemon"
    self.setupTableView()
    if let pokeListCache = self.getPokeListCache(), !pokeListCache.isEmpty {
      self.pokemonList = pokeListCache
      self.tableView.reloadData()
    } else {
      self.callAPI(url: "https://pokeapi.co/api/v2/pokemon/")
    }
    
  }
  
}

extension MainMenuVC {
  
  func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
  }
  
  func showAlert(message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil)
    alert.addAction(dismissAction)
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension MainMenuVC {
  
  func callAPI(url: String) {
    WorkerPokemon.doGetPokemonList(url: url) { dataRequest in
      
    } onSuccess: { result in
      self.pokemonTemporary = result
      self.process()
    } onFailed: { message, code in
      if code == -1009 {
        self.showAlert(message: message)
      } else {
        
      }
    }
  }
  
  func process() {
    if let pokeList = self.pokemonTemporary?.results, !pokeList.isEmpty {
      let queue = OperationQueue()
      queue.maxConcurrentOperationCount = 2
      self.apiFailed.removeAll() // reset
      self.processPokemonList(list: pokeList, queue: queue)
    } else {
      // ?
    }
  }
  
  func processPokemonList(list: [DAOPokemonListResults], queue: OperationQueue) {
    for (index, obj) in list.enumerated() {
      if obj.pokemonDetail == nil {
        self.getPokemonDetailAPI(row: index, url: obj.url ?? "", queue: queue) { dataRequest in
          
        } onSuccess: { row, result in
          self.pokemonTemporary?.results![row].pokemonDetail = result
          self.successCount += 1
          self.check(queue: queue)
        } onFailed: { message, code in
          self.apiFailed.append(list[code ?? 0])
          self.check(queue: queue)
        }
      }
    }
  }
  
  func check(queue: OperationQueue) {
    if (self.successCount + self.apiFailed.count) == self.pokemonTemporary?.results?.count {
      //      if self.apiFailed.isEmpty {
      self.pokemonList.append(self.pokemonTemporary!)
      self.pokemonTemporary = nil
      self.apiFailed.removeAll()
      self.successCount = 0
      self.tableView.reloadData()
      SessionManager.instance.setPokemonList(pokemonList: self.pokemonList)
      //      queue.cancelAllOperations()
      //      } else {
      //        self.process()
      // problem: id 12 15 19 20 always failed
      //      }
    } else {
      // do nothing
    }
  }
  
  func getPokemonDetailAPI(row: Int, url: String, queue: OperationQueue, onRequest: @escaping onRequest, onSuccess: @escaping (_ row: Int ,_ result: DAOPokemonDetailBaseClass) -> Void, onFailed: @escaping onError) {
    let operation = NetworkOperation(urlString: url) { urlString, responseObject, error in
      guard let responseObject = responseObject else {
        print("failed: \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      let jsonData = (responseObject.rawString() ?? "").data(using: .utf8)
      if let jsonData = jsonData, let obj = try? JSONDecoder().decode(DAOPokemonDetailBaseClass.self, from: jsonData) {
        onSuccess(row, obj)
      } else {
        onFailed(urlString, row)
      }
    }
    queue.addOperation(operation)
  }
  
  func getPokeListCache() -> [DAOPokemonListBaseClass]? {
    return SessionManager.instance.getPokemonList()
  }
  
}

extension MainMenuVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.pokemonList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.pokemonList[section].results?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell ?? PokemonCell()
    let data = self.pokemonList[indexPath.section].results?[indexPath.row]
    cell.pokemonNameLabel.text = data?.name ?? ""
    cell.pokemonImageView?.sd_setImage(with: URL(string: data?.pokemonDetail?.sprites?.frontDefault ?? "")) { (img, err, cache, url) in
      if err == nil {
        //            self.setupImageRatio(image: img ?? UIImage())
        cell.pokemonImageView.image = img
      } else {
        cell.pokemonImageView?.image = nil
        cell.pokemonImageView?.backgroundColor = UIColor.white
      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastSectionIndex = tableView.numberOfSections - 1
    let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
    if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
      // print("this is the last cell")
      let spinner = UIActivityIndicatorView(style: .gray)
      spinner.startAnimating()
      spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
      
      self.tableView.tableFooterView = spinner
      self.tableView.tableFooterView?.isHidden = false
      let lastSection = self.pokemonList.count - 1
      let lastRow = (self.pokemonList[lastSection].results?.count ?? 1) - 1
      //        if indexPath == IndexPath(row: lastRow, section: lastSection) {
      
      self.callAPI(url: self.pokemonList[lastSection].next ?? "")
      //        } else {
      
      //        }
    }
  }
  
  private func hideBottomLoader() {
    DispatchQueue.main.async {
      //              let lastListIndexPath = IndexPath(row: self.users.count - 1, section: TableSection.userList.rawValue)
      let lastSection = self.pokemonList.count - 1
      let lastListIndexPath = IndexPath(row: (self.pokemonList[lastSection].results?.count ?? 1) - 1, section: lastSection)
      self.tableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    Wireframe.performToPokemonDetail(caller: self)
  }
  
}
