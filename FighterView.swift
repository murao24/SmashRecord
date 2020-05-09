//
//  FighterView.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class FighterView: UIView {

    @IBOutlet weak var fighterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
}
