//
//  Wireframe.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import UIKit

struct Wireframe {
  
  static let moduleName = "PokeApp"
  static let bundle = "bundle"
  
  static func performToMain(caller: UIViewController) {
    let storyboard = UIStoryboard(name: "MainMenu", bundle: mainBundle)
    let nav = storyboard.instantiateInitialViewController() as? UINavigationController ?? UINavigationController()
    if caller.navigationController == nil {
      caller.addChild(nav)
      caller.view.addSubview(nav.view)
      nav.didMove(toParent: caller)
    } else {
      caller.navigationController?.pushViewController(nav, animated: true)
    }
  }
  
  static func performToPokemonDetail(caller: UIViewController, pokemonData: DAOPokemonListResults?) {
    let storyboard = UIStoryboard(name: "PokemonDetail", bundle: mainBundle)
    let nav = storyboard.instantiateInitialViewController() as? UINavigationController ?? UINavigationController()
    let vc = nav.topViewController as? PokemonDetailVC ?? PokemonDetailVC()
//    let vc = storyboard.instantiateInitialViewController() as? PokemonDetailVC ?? PokemonDetailVC()
    vc.pokemonData = pokemonData
    if caller.navigationController == nil {
      caller.addChild(nav)
      caller.view.addSubview(nav.view)
      nav.didMove(toParent: caller)
    } else {
      caller.navigationController?.pushViewController(vc, animated: true)
//      caller.present(vc, animated: true, completion: nil)
    }
  }
  
  static func initDetailStats(pokemonData: DAOPokemonListResults?) -> UIViewController {
    let storyboard = UIStoryboard(name: "PokemonDetailStats", bundle: mainBundle)
    let vc = storyboard.instantiateInitialViewController() as? PokemonDetailStatsVC ?? PokemonDetailStatsVC()
    vc.pokemonData = pokemonData
    return vc
  }
  
  static func initDetailEvo(pokemonData: DAOPokemonListResults?) -> UIViewController {
    let storyboard = UIStoryboard(name: "PokemonDetailEvo", bundle: mainBundle)
    let vc = storyboard.instantiateInitialViewController() as? PokemonDetailEvoVC ?? PokemonDetailEvoVC()
    return vc
  }
  
}

extension Wireframe {
  
  static var mainBundle: Bundle {
    let podBundle = Bundle(for: ViewController.self)
    let bundleURL = podBundle.url(forResource: moduleName, withExtension: bundle)
    if bundleURL == nil {
      return podBundle
    } else {
      return Bundle(url: bundleURL!) ?? Bundle()
    }
  }
  
}
