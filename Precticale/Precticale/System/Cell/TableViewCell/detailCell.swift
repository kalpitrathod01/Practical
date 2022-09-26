//
//  detailCell.swift
//  Precticale
//
//  Created by Kalpit Rathod on 26/09/22.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTital: UILabel!
    @IBOutlet var viewBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
