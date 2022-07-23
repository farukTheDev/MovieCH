//
//  ViewController.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 20.07.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()

    var viewModel = {
        MovieListViewModel()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        viewModel.fetchData()
        
       
        viewModel.setupTableView = { [weak self] in
            self?.tableView.register(UINib(nibName: "MovieListCell", bundle: nil),
                               forCellReuseIdentifier: MovieListCell.identifier)
            self?.tableView.register(UINib(nibName: "MovieListSliderCell", bundle: nil),
                               forCellReuseIdentifier: MovieListSliderCell.identifier)
            
            
            self?.tableView.delegate = self
            self?.tableView.dataSource = self
            if self!.refreshControl.isRefreshing {
                self?.refreshControl.endRefreshing()
            }
        }
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.connectionError = { [weak self] in
            let vc = Constants.mainStoryBoard.instantiateViewController(withIdentifier: ConnectionErrorViewController.identifier)
            vc.modalPresentationStyle = .formSheet
            self?.present(vc, animated: true)
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchData()
    }
    
    func loadMore() {
        viewModel.page += 1
        viewModel.fetchData()
    }
    
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.movieCellViewModels.isEmpty {
            return 0
        }
        return viewModel.movieCellViewModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListSliderCell.identifier,
                                                     for: indexPath) as! MovieListSliderCell
            cell.viewModel = viewModel.movieListSliderCellViewModel
            cell.parentVC = self
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier,
                                                     for: indexPath) as! MovieListCell
            cell.configUIWithVM(viewModel: viewModel.movieCellViewModels[indexPath.row - 1])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let screenSize: CGRect = UIScreen.main.bounds
            return screenSize.width / 375 * 256
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.movieCellViewModels.count && !viewModel.isLoading {
            loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let vm = MovieDetailViewModel()
            vm.fetchMovie(id: viewModel.movieCellViewModels[indexPath.row - 1].id)
            vm.navigate = { [weak self] in
                let vc = Constants.mainStoryBoard.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
                vc.viewModel = vm
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            vm.connectionError = { [weak self] in
                let vc = Constants.mainStoryBoard.instantiateViewController(withIdentifier: ConnectionErrorViewController.identifier)
                vc.modalPresentationStyle = .formSheet
                self?.present(vc, animated: true)
            }
        }
    }
}
