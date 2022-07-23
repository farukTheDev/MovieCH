//
//  MovieDetailViewController.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var viewModel: MovieDetailViewModel?
    
    static let identifier = "MovieDetailViewController"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let vm = viewModel {
            configUIWithVM(viewModel: vm)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack(_:))))
        
        imdbImageView.isUserInteractionEnabled = true
        imdbImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapIMDB(_:))))
    }
    
    @objc func onTapIMDB(_ sender: UITapGestureRecognizer){
        if let url = URL(string: Urls.IMDB_LINK(imdb_id: viewModel!.imdb_id)) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func onTapBack(_ sender: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    
    func configUIWithVM(viewModel: MovieDetailViewModel) {
        pageTitleLabel.text = viewModel.title
        movieTitleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rate
        posterImageView.kf.setImage(with: URL(string: viewModel.poster)!)
        movieDescLabel.text = viewModel.overView
        releaseDateLabel.text = viewModel.date
    }

}
