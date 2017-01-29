//
//  ViewController.swift
//  ASDKRotation
//
//  Created by Ryan Fitzgerald on 1/29/17.
//  Copyright © 2017 Ryan Fitzgerald. All rights reserved.
//

import UIKit
import AsyncDisplayKit

final class ASDKViewController: ASViewController<ASCollectionNode> {

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if traitCollection.userInterfaceIdiom == .pad {
      return .all
    } else {
      return [.portrait, .portraitUpsideDown]
    }
  }

  init() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0

    let node = ASCollectionNode(collectionViewLayout: layout)
    super.init(node: node)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    node.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
    node.dataSource = self
    node.delegate = self
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
}

extension ASDKViewController: ASCollectionDataSource {

  func numberOfSectionsInCollectionNode(collectionNode: ASCollectionNode) -> Int {
    return 1
  }

  func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    return 500
  }

  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    let block: ASCellNodeBlock = {
      let result = ASTextCellNode()
      result.text = "Cell \(indexPath.item)"
      result.backgroundColor = UIColor.lightGray
      return result
    }

    return block
  }

  func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {

    if kind == UICollectionElementKindSectionHeader {
      let result = ASTextCellNode()
      result.text = "ASViewController"
      result.textInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 20)
      result.backgroundColor = UIColor.white
      return result
    }

    return ASCellNode()
  }

}

extension ASDKViewController: ASCollectionDelegate {

  func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
    if traitCollection.horizontalSizeClass == .compact {
      let width: CGFloat = collectionNode.bounds.width - 30
      let heightToWidthRatio: CGFloat = 275 / 580.0
      let size = CGSize(width: width, height: width * heightToWidthRatio)
      return ASSizeRange(min: size, max: size)
    } else {
      let size = CGSize(width: 220.5, height: 126)
      return ASSizeRange(min: size, max: size)
    }
  }

  func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
    print("did select \(indexPath)")
    self.show(LandscapeViewController(), sender: nil)
  }
}

extension ASDKViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {

    return CGSize(width: collectionView.bounds.size.width, height: 60)
  }
}
