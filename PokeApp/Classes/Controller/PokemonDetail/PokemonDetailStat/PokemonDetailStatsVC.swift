//
//  PokemonDetailStatsVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import UIKit

class PokemonDetailStatsVC: UIViewController {
  
  @IBOutlet weak var parentStackView: UIStackView!
  
  let abilitiesList: [AbilitiesModel] = [AbilitiesModel(title: "Torrent", desc: "Power up Water-type moves when the Pokemon is in trouble."), AbilitiesModel(title: "Rain Dish", desc: "The Pokemon gradually regains HP in rain.")]
  
  let breedingList: [BreedingModel] = [BreedingModel(eggGroup: "Monster", hatchTime: "5101 Steps", gender: "12.5%"), BreedingModel(eggGroup: "Water I", hatchTime: "20 Cycles", gender: "87.5%")]
  
  let captureList: [CaptureModel] = [CaptureModel(habitat: "Waters-Edge", generation: "Generation 1", captureRate: "45%")]
  
  let spritesList: [SpritesModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.parentStackView.addArrangedSubview(self.createStats(total: 5))
    self.parentStackView.addArrangedSubview(self.createWeaknesses(totalItem: 20, totalItemInRow: 3))
    self.parentStackView.addArrangedSubview(self.createAbilities(abilitiesList: self.abilitiesList))
    self.parentStackView.addArrangedSubview(self.createBreeding(breedingList: self.breedingList))
    self.parentStackView.addArrangedSubview(self.createCapture(captureList: self.captureList))
    self.parentStackView.addArrangedSubview(self.createSprites(spritesList: self.spritesList))
  }
  
  func createHeaderView(withTitle title: String) -> UILabel {
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return titleLabel
  }
}

// MARK: - STATS
extension PokemonDetailStatsVC {
  
  func createStats(total: Int) -> UIStackView {
    let horizontalStack = UIStackView()
    horizontalStack.axis = .vertical
    horizontalStack.alignment = .fill
    horizontalStack.distribution = .fill
    horizontalStack.spacing = 10
    
    for _ in 0 ... total - 1 {
      horizontalStack.addArrangedSubview(self.createStatsView())
    }
    
    return horizontalStack
  }
  
  func createStatsView() -> UIStackView {
    let verticalStack = UIStackView()
    verticalStack.axis = .horizontal
    verticalStack.alignment = .fill
    verticalStack.distribution = .fill
    verticalStack.spacing = 10
    
    let statLabel = UILabel()
    statLabel.text = "HP"
    statLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let statNumberLabel = UILabel()
    statNumberLabel.text = "000"
    statNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let progressView = UIProgressView()
    progressView.progressTintColor = .blue
    progressView.setProgress(0.3, animated: true)
    progressView.trackTintColor = .lightGray
    progressView.translatesAutoresizingMaskIntoConstraints = false
    
    verticalStack.addArrangedSubview(statLabel)
    verticalStack.addArrangedSubview(statNumberLabel)
    verticalStack.addArrangedSubview(progressView)
    
    return verticalStack
  }
  
}

// MARK: - WEAKNESSES
extension PokemonDetailStatsVC {
  
  func createWeaknesses(totalItem: Int, totalItemInRow: Int) -> UIStackView {
    let horizontalStack = UIStackView()
    horizontalStack.axis = .vertical
    horizontalStack.alignment = .fill
    horizontalStack.distribution = .fill
    horizontalStack.spacing = 10
    
    horizontalStack.addArrangedSubview(self.createHeaderView(withTitle: "Weaknesses"))
    
    let totalItemInLastRow = totalItem % totalItemInRow
    let totalRow = Int(totalItem / totalItemInRow) + (totalItemInLastRow > 0 ? 1 : 0)
    
    for index in 0 ... totalRow - 1 {
      horizontalStack.addArrangedSubview(self.createWeaknessRow(totalItem: index == (totalRow - 1) ? (totalItemInLastRow == 0 ? totalItemInRow : totalItemInLastRow) : totalItemInRow, totalItemInRow: totalItemInRow))
    }
    
    return horizontalStack
  }
  
  func createWeaknessRow(totalItem: Int, totalItemInRow: Int) -> UIStackView {
    let verticalStack = UIStackView()
    verticalStack.axis = .horizontal
    verticalStack.alignment = .fill
    verticalStack.distribution = .fillEqually
    verticalStack.spacing = 10
    
    for _ in 0 ... totalItem - 1 {
      verticalStack.addArrangedSubview(self.createWeaknessView())
    }
    
    if totalItemInRow != totalItem {
      for _ in 0 ... (totalItemInRow - totalItem) - 1 {
        verticalStack.addArrangedSubview(UIView())
      }
    } else {
      // do nothing
    }
    
    return verticalStack
  }
  
  func createWeaknessView() -> UIStackView {
    let verticalStack = UIStackView()
    verticalStack.axis = .horizontal
    verticalStack.alignment = .fill
    verticalStack.distribution = .fill
    verticalStack.spacing = 5
    
    let iconImageView = UIImageView()
    iconImageView.backgroundColor = .blue
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    
    iconImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: iconImageView, attribute: .width, multiplier: 1, constant: 10))
    iconImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: iconImageView, attribute: .height, multiplier: 1, constant: 10))
    
    let titleLabel = UILabel()
    titleLabel.text = "2x"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    verticalStack.addArrangedSubview(iconImageView)
    verticalStack.addArrangedSubview(titleLabel)
    
    return verticalStack
  }
  
}

// MARK: - ABILITIES
extension PokemonDetailStatsVC {
  
  func createAbilities(abilitiesList: [AbilitiesModel]) -> UIStackView {
    let horizontalStack = UIStackView()
    horizontalStack.axis = .vertical
    horizontalStack.alignment = .fill
    horizontalStack.distribution = .fill
    horizontalStack.spacing = 10
    
    horizontalStack.addArrangedSubview(self.createHeaderView(withTitle: "Abilities"))
    
    for (_, obj) in abilitiesList.enumerated() {
      horizontalStack.addArrangedSubview(self.createAbilitiesView(abilities: obj))
    }
    
    return horizontalStack
  }
  
  func createAbilitiesView(abilities: AbilitiesModel) -> UIStackView {
    let verticalStack = UIStackView()
    verticalStack.axis = .vertical
    verticalStack.alignment = .fill
    verticalStack.distribution = .fill
    verticalStack.spacing = 10
    
    let abilitiesNameLabel = UILabel()
    abilitiesNameLabel.text = abilities.abilitiesTitle
    abilitiesNameLabel.numberOfLines = 0
    abilitiesNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let abilitiesDescLabel = UILabel()
    abilitiesDescLabel.text = abilities.abilitiesDesc
    abilitiesDescLabel.numberOfLines = 0
    abilitiesDescLabel.translatesAutoresizingMaskIntoConstraints = false
    
    verticalStack.addArrangedSubview(abilitiesNameLabel)
    verticalStack.addArrangedSubview(abilitiesDescLabel)
    
    return verticalStack
  }
  
}

// MARK: - BREEDING
extension PokemonDetailStatsVC {
  
  func createBreeding(breedingList: [BreedingModel]) -> UIStackView {
    
    return UIStackView()
  }
  
}

// MARK: - CAPTURE
extension PokemonDetailStatsVC {
  
  func createCapture(captureList: [CaptureModel]) -> UIStackView {
    
    return UIStackView()
  }
  
}

// MARK: - SPRITES
extension PokemonDetailStatsVC {
  
  func createSprites(spritesList: [SpritesModel]) -> UIStackView {
    
    return UIStackView()
  }
  
}
