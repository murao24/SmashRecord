//
//  CustomTableViewCell.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class FighterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fighterView: UIImageView!
    @IBOutlet weak var fighterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
