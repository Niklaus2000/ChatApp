//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by MacBoobPro on 03.05.23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MessageTableViewCell"
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
    
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  self.reuseIdentifier = "MessageTableViewCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
