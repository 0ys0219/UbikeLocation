//
//  OptionTableViewCell.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var optionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        optionLabel.textColor = .white
        optionLabel.setTextSpacingBy(value: 1.5)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension UILabel {
  func setTextSpacingBy(value: Double) {
    if let textString = self.text {
      let attributedString = NSMutableAttributedString(string: textString)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
