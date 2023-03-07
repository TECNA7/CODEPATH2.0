//
//  DetailsTableViewCell.swift
//  YourMovie
//
//  Created by Kripa Lamichhane on 3/4/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
 
    
    
    
    
    
    
      @IBOutlet weak
        var titleLabel: UILabel!
            @IBOutlet weak
        var movieImage: UIImageView!
            @IBOutlet weak
        var releaseDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = movieImage.bounds.width / 8
                   movieImage.clipsToBounds = true
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
