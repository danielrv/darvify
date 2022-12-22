//
//  ArtistaTableViewCell.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import UIKit

class ArtistaTableViewCell: UITableViewCell {

    @IBOutlet var lblNombreArtista:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
