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
  
  func setupView(data: DAOPokemonListResults?) {
    self.pokemonNameLabel.text = data?.name ?? ""
    self.pokemonImageView?.sd_setImage(with: URL(string: data?.pokemonDetail?.sprites?.frontDefault ?? "")) { (img, err, cache, url) in
      if err == nil {
        self.pokemonImageView.image = img
      } else {
        self.pokemonImageView?.image = nil
        self.pokemonImageView?.backgroundColor = UIColor.white
      }
    }
  }
  
}
