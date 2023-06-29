//
//  FriendsTableViewCell.swift
//  DemoFriend26062023
//
//  Created by Nguyễn Mạnh Linh on 26/06/2023.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblNameAndNick: UILabel!
    @IBOutlet weak var imgAvtFriends: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
