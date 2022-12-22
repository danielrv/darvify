//
//  NewReleasesTableViewCell.swift
//  ee.darv.Darvify
//
//  Created by Dan on 21-12-22.
//

import UIKit

class NewReleasesTableViewCell: UITableViewCell {

    @IBOutlet var poster:UIImageView?
    @IBOutlet var lblTitulo:UILabel?
    @IBOutlet var lblGenero:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
