//
//  PostTableViewCell.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var postTextView: UITextView!
}
