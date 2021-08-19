//
//  PokemonDetailVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import UIKit
import MXSegmentedPager

class PokemonDetailVC: MXSegmentedPagerController {
  
  @IBOutlet weak var headerView: UIView!
  
  let pageTitle = ["Stats", "Evolutions"]
  let pageController = [Wireframe.initDetailStats(), Wireframe.initDetailEvo()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedPager.backgroundColor = .white
    
    // Parallax Header
    segmentedPager.parallaxHeader.view = headerView
    segmentedPager.parallaxHeader.mode = .fill
    segmentedPager.parallaxHeader.height = 150
    segmentedPager.parallaxHeader.minimumHeight = view.safeAreaInsets.top
    
    // Segmented Control customization
    segmentedPager.segmentedControl.indicator.linePosition = .bottom
    segmentedPager.segmentedControl.textColor = .black
    segmentedPager.segmentedControl.selectedTextColor = .orange
    segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .orange
  }
  
  override func viewSafeAreaInsetsDidChange() {
    segmentedPager.parallaxHeader.minimumHeight = view.safeAreaInsets.top
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
    return self.pageTitle[index]
  }
  
  override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
    print("progress \(parallaxHeader.progress)")
  }
  
  override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
    return self.pageTitle.count
  }
  
  override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
    return self.pageController[index]
  }
  
}
