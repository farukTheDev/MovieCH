//
//  MovieSliderCell.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit

class MovieSliderCell: UICollectionViewCell {
    
    static let identifier = "MovieSliderCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configUIWithVM(viewModel: MovieSliderCellViewModel){
        titleLabel.text = viewModel.name
        descLabel.text = viewModel.desc
        posterImageView.kf.setImage(with: URL(string: viewModel.poster)!)
    }
    
}
