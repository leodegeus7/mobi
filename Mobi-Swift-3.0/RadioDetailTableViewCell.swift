//
//  RadioDetailTableViewCell.swift
//  Mobi-Swift-3.0
//
//  Created by Desenvolvimento Access Mobile on 9/27/16.
//  Copyright © 2016 Access Mobile. All rights reserved.
//

import UIKit

class RadioDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imageRadio: UIImageView!
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var labelLocal: UILabel!
  @IBOutlet weak var imageHeart: UIImageView!
  @IBOutlet weak var labelLikes: UILabel!
  @IBOutlet weak var labelScore: UILabel!
  @IBOutlet weak var viewBack: UIView!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var labelLikesDescr: UILabel!
  @IBOutlet weak var labelScoreDescr: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let colorAlpha = DataManager.sharedInstance.interfaceColor.color.withAlphaComponent(0.2)
    let viewSelected = UIView()
    viewSelected.backgroundColor = colorAlpha
    self.selectedBackgroundView = viewSelected
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
