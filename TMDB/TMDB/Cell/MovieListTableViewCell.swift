//
//  MovieListTableViewCell.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bind(title: String, subTitle: String, details: String, url: String){
        lblTitle.text = title
        lblSubTitle.text = subTitle
        let imgURLName = ApiConstants.smallImageUrlString+(url)
        self.artImageView.imageWith(urlString:imgURLName, placeholder: "logo-icon")
    }
}
