//
//  MainMenuVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 17/08/21.
//

import UIKit
import SDWebImage
import PromiseKit

class MainMenuVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var pokemonList: [DAOPokemonListBaseClass] = []
  var pokemonTemporary: DAOPokemonListBaseClass?
  
  var successCount = 0
  var apiFailed: [DAOPokemonListResults] = []
  var isNeedToReloadTable: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.setupNavigationBar()
    self.setupTableView()
    if let pokeListCache = self.getPokeListCache(), !pokeListCache.isEmpty {
      self.pokemonList = pokeListCache
      self.tableView.reloadData()
    } else {
      self.getPokemonData(url: "https://pokeapi.co/api/v2/pokemon/")
    }
  }
  
}

extension MainMenuVC {
  
  func setupNavigationBar() {
    // Find size for blur effect.
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    let bounds = self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
    // Create blur effect.
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    visualEffectView.frame = bounds!
    // Set navigation bar up.
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.addSubview(visualEffectView)
    self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
    
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationItem.title = "Pokemon"
  }
  
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

// MARK: - GET API
extension MainMenuVC {
  
  func getPokemonData(url: String) {
    WorkerPokemon.getPokemonAPI(url: url)
      .then { pokemonData -> Promise<DAOPokemonListBaseClass> in
        var pokemonDataTmp = pokemonData
        var resultList: [DAOPokemonListResults] = []
        guard let results = pokemonData.results, !results.isEmpty else { return WorkerPokemon.brokenPromise() }
        
        Promise.value(results)
          .thenMap { result -> Promise<DAOPokemonListResults> in
            var resultTmp = result
            WorkerPokemon.getPokemonDetailAPIs(url: result.url ?? "")
              .done { detail in
                resultTmp.pokemonDetail = detail
                resultList.append(resultTmp)
              }
              .catch { error in
                
              }
              .finally {
                
                if pokemonDataTmp.results?.count == resultList.count && self.isNeedToReloadTable {
                  pokemonDataTmp.results = resultList
                  self.pokemonList.append(pokemonDataTmp)
                  self.savePokeListCache()
                  self.tableView.reloadData()
                  self.isNeedToReloadTable = false
                } else {
                  
                }
              }
            return Promise.value(resultTmp)
          }
          .done { result in
            
          }
          .catch { error in
            
          }
          .finally {
            
          }
        
        return Promise.value(pokemonDataTmp)
      }
      .done { pokemonData in
        
      }
      .catch { error in
        
      }
      .finally {
        
      }
      
  }
  
}

// MARK: - CACHE
extension MainMenuVC {
  
  func savePokeListCache() {
    SessionManager.instance.setPokemonList(pokemonList: self.pokemonList)
  }
  
  func getPokeListCache() -> [DAOPokemonListBaseClass]? {
    return SessionManager.instance.getPokemonList()
  }
  
}

// MARK: - TABLE VIEW
extension MainMenuVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.pokemonList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.pokemonList[section].results?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell ?? PokemonCell()
    cell.setupView(data: self.pokemonList[indexPath.section].results?[indexPath.row])
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
              if indexPath == IndexPath(row: lastRow, section: lastSection) {
      
//      self.callAPI(url: self.pokemonList[lastSection].next ?? "")
      self.isNeedToReloadTable = true
      self.getPokemonData(url: self.pokemonList[lastSection].next ?? "")
              } else {
      
              }
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
    Wireframe.performToPokemonDetail(caller: self, pokemonData: self.pokemonList[indexPath.section].results?[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
