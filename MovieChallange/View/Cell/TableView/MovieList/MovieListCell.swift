//
//  MovieListCell.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {
    
    static let identifier = "MovieListCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUIWithVM(viewModel: MovieListCellViewModel){
        titleLabel.text = viewModel.name
        descLabel.text = viewModel.desc
        dateLabel.text = viewModel.date
        posterImageView.kf.setImage(with: URL(string: viewModel.poster)!)
    }
    
}
