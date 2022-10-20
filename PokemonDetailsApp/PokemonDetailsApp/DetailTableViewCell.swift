//
//  DetailTableViewCell.swift
//  PokemonDetailsApp
//
//  Created by Yavuz Güner on 19.10.2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //Stats verileri için custom oluşturduğumuz tableview'in üzerine yerleştirdiğimiz labelları buraya tanımladım.
    @IBOutlet weak var statValueLabel: UILabel!
    @IBOutlet weak var statNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
