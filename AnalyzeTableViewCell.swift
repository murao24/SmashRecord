//
//  AnalyzeTableViewCell.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AnalyzeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fighterLabel: UIImageView!
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
