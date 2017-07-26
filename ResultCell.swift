//
//  result.swift
//  ENT
//
//  Created by Dinmukhammed on 20.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var curQuestonNumber: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var wrongAnswerText: UILabel!
    @IBOutlet weak var rightAnswerText: UILabel!
  
    @IBOutlet weak var contentBlock: UIView!
    @IBOutlet weak var wrongImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
