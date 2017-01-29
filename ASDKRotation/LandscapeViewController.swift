//
//  LandscapeViewController.swift
//  ASDKRotation
//
//  Created by Ryan Fitzgerald on 1/29/17.
//  Copyright © 2017 Ryan Fitzgerald. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

final class SampleNode: ASDisplayNode {
  lazy var backButton: ASButtonNode = {
    let result = ASButtonNode()
    let font = UIFont.systemFont(ofSize: 19, weight: UIFontWeightLight)
    result.setTitle("Dismiss", with: font, with: UIColor.red, for: [])
    return result
  }()

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASCenterLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: [], child: backButton)
  }
}

final class LandscapeViewController: ASViewController<SampleNode> {

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }

  init() {
    super.init(node: SampleNode())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    node.backgroundColor = UIColor.yellow.withAlphaComponent(0.25)
    node.backButton.addTarget(self, action: #selector(tappedBackButton), forControlEvents: .touchUpInside)
  }

  func tappedBackButton() {
    print("back tapped")
    self.dismiss(animated: true, completion: nil)
  }
}
