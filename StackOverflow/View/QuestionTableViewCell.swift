//
//  QuestionTableViewCell.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/12/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var AnswerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(title:String, owner:String, answerCount:String) {
        titleLabel.text = title
        ownerLabel.text  = owner
        AnswerCountLabel.text = answerCount
    }

}
