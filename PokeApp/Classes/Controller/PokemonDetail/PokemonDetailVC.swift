//
//  PokemonDetailVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import UIKit
import MXSegmentedPager

struct SegmentedPagerController {
  var title: String
  var controller: UIViewController
  
  init(title: String, controller: UIViewController) {
    self.title = title
    self.controller = controller
  }
}

//class PokemonDetailVC: UIViewController {
//
//  @IBOutlet weak var headerView: UIView!
//
////  let pageTitle = ["Stats", "Evolutions"]
////  let pageController = [Wireframe.initDetailStats(), Wireframe.initDetailEvo()]
//
//  var pokemonData: DAOPokemonListBaseClass?
//  var segmentedPagerControllerList: [SegmentedPagerController] = []
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    self.setupPageController()
////    segmentedPager.backgroundColor = .white
////
////    // Parallax Header
////    segmentedPager.parallaxHeader.view = headerView
////    segmentedPager.parallaxHeader.mode = .fill
////    segmentedPager.parallaxHeader.height = 150
////    segmentedPager.parallaxHeader.minimumHeight = view.safeAreaInsets.top
////
////    // Segmented Control customization
////    segmentedPager.segmentedControl.indicator.linePosition = .bottom
////    segmentedPager.segmentedControl.textColor = .black
////    segmentedPager.segmentedControl.selectedTextColor = .orange
////    segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .orange
//  }
//
//  func setupPageController() {
//    let detailStatsController = Wireframe.initDetailStats(pokemonData: self.pokemonData)
//    let detailEvoController = Wireframe.initDetailEvo(pokemonData: self.pokemonData)
//
//    self.segmentedPagerControllerList.append(SegmentedPagerController(title: "Stats", controller: detailStatsController))
//    self.segmentedPagerControllerList.append(SegmentedPagerController(title: "Evolutions", controller: detailEvoController))
//  }
//
//  override func viewSafeAreaInsetsDidChange() {
////    segmentedPager.parallaxHeader.minimumHeight = view.safeAreaInsets.top
//  }
//
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//  }
//
////  override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
////    return self.segmentedPagerControllerList[index].title
////  }
//
////  override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
////    print("progress \(parallaxHeader.progress)")
////  }
//
////  override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
////    return self.segmentedPagerControllerList.count
////  }
//
////  override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
////    return self.segmentedPagerControllerList[index].controller
////  }
//
//}

class PokemonDetailVC: UIViewController {
  
  // Defined UI views
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Lorem Ipsum"
    label.font = .boldSystemFont(ofSize: 32)
    return label
  }()
  
  lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.isEditable = false
    textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sem fringilla ut morbi tincidunt augue interdum. Ut morbi tincidunt augue interdum velit euismod in pellentesque massa. Pulvinar etiam non quam lacus suspendisse faucibus interdum posuere. Mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a. Eget nullam non nisi est sit amet. Odio pellentesque diam volutpat commodo. Id eu nisl nunc mi ipsum faucibus vitae. "
    return textView
  }()
  
  lazy var registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Get Started", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = view.tintColor
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    return button
  }()
  
  lazy var containerStackView: UIStackView = {
    let spacer = UIView()
    let stackView = UIStackView(arrangedSubviews: [titleLabel, textView, spacer, registerButton])
    stackView.axis = .vertical
    stackView.spacing = 16.0
    return stackView
  }()
  
  var pokemonData: DAOPokemonListResults?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //      setupView()
    //      setupConstraints()
    // Add action
    //      registerButton.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    self.presentModalController()
  }
  
  @IBAction func dismissButtonAction(_ sender: UIBarButtonItem) {
    print(#function)
    self.navigationController?.popViewController(animated: true)
  }
  
  func setupView() {
    // cosmetics
    view.backgroundColor = .systemBackground
  }
  
  // Add subviews and set constraints
  func setupConstraints() {
    view.addSubview(containerStackView)
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    // Call .activate method to enable the defined constraints
    NSLayoutConstraint.activate([
      // 6. Set containerStackView edges to superview with 24 spacing
      containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
      containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
      containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
      containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
      // 7. Set button height
      registerButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  // To be updated
  func presentModalController() {
    let vc = PokemonDetailModalController()
    vc.pokemonData = self.pokemonData
    vc.modalPresentationStyle = .overCurrentContext
    // keep false
    // modal animation will be handled in VC itself
    self.present(vc, animated: false)
  }
}
