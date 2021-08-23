//
//  PokemonDetailModalController.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 23/08/21.
//

import UIKit
import MXSegmentedPager
import MXSegmentedControl

class PokemonDetailModalController: UIViewController {
  
  lazy var contentStackView: UIStackView = {
    let spacer = UIView()
    //    let stackView = UIStackView(arrangedSubviews: [titleLabel, notesLabel, spacer])
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 12.0
    return stackView
  }()
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    return view
  }()
  
  let maxDimmedAlpha: CGFloat = 0.6
  lazy var dimmedView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.alpha = maxDimmedAlpha
    return view
  }()
  
  // Constants
  let defaultHeight: CGFloat = UIScreen.main.bounds.height - 300
  let dismissibleHeight: CGFloat = 200
  let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 100
  
  // keep current new height, initial is default height
  var currentContainerHeight: CGFloat = 300
  
  // Dynamic container constraint
  var containerViewHeightConstraint: NSLayoutConstraint?
  var containerViewBottomConstraint: NSLayoutConstraint?
  
  var pokemonData: DAOPokemonListResults?
  var segmentedPagerControllerList: [SegmentedPagerController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupPageController()
    setupView()
    setupConstraints()
    // tap gesture on dimmed view to dismiss
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
//    dimmedView.addGestureRecognizer(tapGesture)
    
    setupPanGesture()
    
    
  }
  
  @objc func handleCloseAction() {
    animateDismissView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    animateShowDimmedView()
    animatePresentContainer()
  }
  
  func setupView() {
    view.backgroundColor = .clear
  }
  
  func setupConstraints() {
    // Add subviews
//    view.addSubview(dimmedView)
    view.addSubview(containerView)
//    dimmedView.translatesAutoresizingMaskIntoConstraints = false
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    contentStackView.addArrangedSubview(self.createPokemonNameLabel())
    contentStackView.addArrangedSubview(self.createPokemonDescLabel())
    contentStackView.addArrangedSubview(self.createSegmentedView())
    
    containerView.addSubview(contentStackView)
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    
    // Set static constraints
    NSLayoutConstraint.activate([
      // set dimmedView edges to superview
//      dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
//      dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//      dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      // set container static constraint (trailing & leading)
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      // content stackView
      contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
      //      contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
      contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20),
      contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
    ])
    
    // Set dynamic constraints
    // First, set container to default height
    // after panning, the height can expand
    containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
    
    // By setting the height to default height, the container will be hide below the bottom anchor view
    // Later, will bring it up by set it to 0
    // set the constant to default height to bring it down again
    containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
    // Activate constraints
    containerViewHeightConstraint?.isActive = true
    containerViewBottomConstraint?.isActive = true
  }
  
  func setupPanGesture() {
    // add pan gesture recognizer to the view controller's view (the whole screen)
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
    // change to false to immediately listen on gesture movement
    panGesture.delaysTouchesBegan = false
    panGesture.delaysTouchesEnded = false
    view.addGestureRecognizer(panGesture)
  }
  
  // MARK: Pan gesture handler
  @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    // Drag to top will be minus value and vice versa
    print("Pan gesture y offset: \(translation.y)")
    
    // Get drag direction
    let isDraggingDown = translation.y > 0
    print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
    
    // New height is based on value of dragging plus current container height
    let newHeight = currentContainerHeight - translation.y
    
    // Handle based on gesture state
    switch gesture.state {
    case .changed:
      // This state will occur when user is dragging
      if newHeight < maximumContainerHeight {
        // Keep updating the height constraint
        containerViewHeightConstraint?.constant = newHeight
        // refresh layout
        view.layoutIfNeeded()
      }
    case .ended:
      // This happens when user stop drag,
      // so we will get the last height of container
      
      // Condition 1: If new height is below min, dismiss controller
      if newHeight < dismissibleHeight {
//        self.animateDismisssView()
      }
      else if newHeight < defaultHeight {
        // Condition 2: If new height is below default, animate back to default
        animateContainerHeight(defaultHeight)
      }
      else if newHeight < maximumContainerHeight && isDraggingDown {
        // Condition 3: If new height is below max and going down, set to default height
        animateContainerHeight(defaultHeight)
      }
      else if newHeight > defaultHeight && !isDraggingDown {
        // Condition 4: If new height is below max and going up, set to max height at top
        animateContainerHeight(maximumContainerHeight)
      }
    default:
      break
    }
  }
  
  func animateContainerHeight(_ height: CGFloat) {
    UIView.animate(withDuration: 0.4) {
      // Update container height
      self.containerViewHeightConstraint?.constant = height
      // Call this to trigger refresh constraint
      self.view.layoutIfNeeded()
    }
    // Save current height
    currentContainerHeight = height
  }
  
  // MARK: Present and dismiss animation
  func animatePresentContainer() {
    // update bottom constraint in animation block
    UIView.animate(withDuration: 0.3) {
      self.containerViewBottomConstraint?.constant = 0
      // call this to trigger refresh constraint
      self.view.layoutIfNeeded()
    }
  }
  
  func animateShowDimmedView() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = self.maxDimmedAlpha
    }
  }
  
  func animateDismissView() {
    // hide blur view
    dimmedView.alpha = maxDimmedAlpha
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = 0
    } completion: { _ in
      // once done, dismiss without animation
      self.dismiss(animated: false)
    }
    // hide main view by updating bottom constraint in animation block
    UIView.animate(withDuration: 0.3) {
      self.containerViewBottomConstraint?.constant = self.defaultHeight
      // call this to trigger refresh constraint
      self.view.layoutIfNeeded()
    }
  }
}

extension PokemonDetailModalController {
  
  func createPokemonNameLabel() -> UILabel {
    let titleLabel = UILabel()
    titleLabel.text = (self.pokemonData?.name ?? "").capitalized
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return titleLabel
  }
  
  func createPokemonDescLabel() -> UILabel {
    let titleLabel = UILabel()
    titleLabel.text = (self.pokemonData?.name ?? "").capitalized
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return titleLabel
  }
  
  func createSegmentedView() -> MXSegmentedPager {
    let segmentedPager = MXSegmentedPager()
    segmentedPager.backgroundColor = .clear
    segmentedPager.segmentedControl.indicator.linePosition = .bottom
    segmentedPager.segmentedControl.textColor = .black
    segmentedPager.segmentedControl.selectedTextColor = .orange
    segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .orange
    segmentedPager.delegate = self
    segmentedPager.dataSource = self
    segmentedPager.translatesAutoresizingMaskIntoConstraints = false
    segmentedPager.heightAnchor.constraint(equalToConstant: maximumContainerHeight).isActive = true
    //    segmentedPager.heightAnchor.constraint(lessThanOrEqualToConstant: maximumContainerHeight).isActive = true
    segmentedPager.sizeToFit()
    
    return segmentedPager
  }
  
}

extension PokemonDetailModalController: MXSegmentedPagerDelegate, MXSegmentedPagerDataSource {
  
  func setupPageController() {
    let detailStatsController = Wireframe.initDetailStats(pokemonData: self.pokemonData)
    let detailEvoController = Wireframe.initDetailEvo(pokemonData: self.pokemonData)
    
    self.segmentedPagerControllerList.append(SegmentedPagerController(title: "Stats", controller: detailStatsController))
    self.segmentedPagerControllerList.append(SegmentedPagerController(title: "Evolutions", controller: detailEvoController))
  }
  
  func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
    return self.segmentedPagerControllerList.count
  }
  
  func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
    return self.segmentedPagerControllerList[index].title
  }
  
  func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index: Int) -> UIView {
    return self.segmentedPagerControllerList[index].controller.view
  }
  
}
