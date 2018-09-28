//
//  ProductCell.swift
//  Search
//
//  Created by reza pahlevi on 9/28/18.
//  Copyright © 2018 tokopedia. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
