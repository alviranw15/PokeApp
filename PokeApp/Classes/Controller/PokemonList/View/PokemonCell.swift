//
//  PokemonCell.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 17/08/21.
//

import UIKit

class PokemonCell: UITableViewCell {
  
  @IBOutlet weak var pokemonImageView: UIImageView!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    
    let backgroundView = UIView()
    let gradient = CAGradientLayer()
    
    gradient.frame = self.contentView.bounds
    // rgba(165,239,252,255)
    // rgba(135,224,252,255)
//    gradient.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
    gradient.colors = [UIColor(red: 165 / 255.0, green: 239 / 255.0, blue: 252 / 255.0, alpha: 1.0).cgColor, UIColor(red: 135 / 255.0, green: 224 / 255.0, blue: 252 / 255.0, alpha: 1.0).cgColor]
    self.selectedBackgroundView = backgroundView
    self.selectedBackgroundView?.layer.insertSublayer(gradient, at: 0)
  }
  
  func setupView(tableView: UITableView, data: DAOPokemonListResults?) {
    // api list: https://pokeapi.co/api/v2/pokemon/
    // image = response.results.url.sprites.front_default // sementara
    // name = response.results.name
//    self.pokemonNameLabel.text = data?.name ?? ""
  }
  
//  func setGradientColor() -> UIView {
//    let backgroundView = UIView()
//    let colors = Colors.init()
//    backgroundView.backgroundColor = UIColor.clear
//    let backgroundLayer = colors.gl
//    backgroundLayer.frame = backgroundView.frame
//    backgroundView.layer.insertSublayer(backgroundLayer, at: 0)
//
//    return backgroundView
//  }
  
}

//class Colors {
//  var gl:CAGradientLayer = CAGradientLayer()
//
//  init() {
//    let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
//    let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
//
//    self.gl = CAGradientLayer()
//    self.gl.colors = [colorTop, colorBottom]
//    self.gl.locations = [0.0, 1.0]
//  }
//}
