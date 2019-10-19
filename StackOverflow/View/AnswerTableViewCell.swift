//
//  AnswerTableViewCell.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/12/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(content:String, owner:String){
        contentTextView.text = content
        ownerLabel.text = owner
    }

}
