//
//  MovieListSliderCell.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit

class MovieListSliderCell: UITableViewCell {
    
    static let identifier = "MovieListSliderCell"
    var parentVC: UIViewController?
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MovieListSliderCellViewModel? {
        didSet {
            cellViewModels = viewModel!.generateMovieSliderCellViewModels()
            collectionView.register(UINib(nibName: MovieSliderCell.identifier, bundle: nil),
                                    forCellWithReuseIdentifier: MovieSliderCell.identifier)
            collectionView.dataSource = self
            collectionView.delegate = self
            
            
        }
    }
    var cellViewModels = [MovieSliderCellViewModel]() {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cellViewModels.count
        }
    }
    
    //var movies = [Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}

extension MovieListSliderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellViewModels.isEmpty {
            return 0
        }
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSliderCell.identifier,
                                                      for: indexPath) as! MovieSliderCell
        cell.configUIWithVM(viewModel: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = MovieDetailViewModel()
        vm.fetchMovie(id: cellViewModels[indexPath.row].id)
        vm.navigate = { [weak self] in
            let vc = Constants.mainStoryBoard.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
            vc.viewModel = vm
            self?.parentVC?.navigationController?.pushViewController(vc, animated: true)
        }
        
        vm.connectionError = { [weak self] in
            let vc = Constants.mainStoryBoard.instantiateViewController(withIdentifier: ConnectionErrorViewController.identifier)
            vc.modalPresentationStyle = .formSheet
            self?.parentVC?.present(vc, animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
    }

}
