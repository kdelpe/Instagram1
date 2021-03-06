//
//  PostCell.swift
//  Instagram
//
//  Created by Kervens Delpe on 10/7/21.
//

import UIKit
import Parse
import AlamofireImage
import RSKPlaceholderTextView

class PostCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
