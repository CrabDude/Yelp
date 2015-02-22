//
//  BusinessCell.swift
//  Yelp
//
//  Created by Adam Crabtree on 2/17/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
    }
    
    func setBusiness(business: Business) {
        self.nameLabel.text = business.name
        self.thumbImageView.setImageWithURL(business.thumbImageUrl)
        self.distanceLabel.text = String(format: "%.2f mi", business.distance! / 1609)
        self.ratingsCountLabel.text = "\(business.reviewCount!) Reviews"
        self.categoryLabel.text = business.categories
        self.ratingImageView.setImageWithURL(business.ratingImageUrl)
        self.addressLabel.text = business.address
    }
    
}
