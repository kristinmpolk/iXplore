//
//  SpotTableViewCell.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/8/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    var logoImageView = UIImageView()
    var placeNameLabel = UILabel()
    var dateLabel = UILabel()
    var favoriteImage = UIImageView()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        logoImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.height, self.frame.height))
        placeNameLabel = UILabel(frame: CGRectMake(self.frame.height+8, 8, 225, 21))
        dateLabel = UILabel(frame: CGRectMake(self.frame.height+8, 43, 225, 21))
        self.addSubview(logoImageView)
        self.addSubview(placeNameLabel)
        self.addSubview(dateLabel)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
