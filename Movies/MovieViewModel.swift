//
//  MovieViewModel.swift
//  Movies
//
//  Created by curs on 6/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import UIKit

enum SelectedType {
    case top
    case fav
}

class MovieViewModel {
    
    var selectedType: SelectedType = .top {
        didSet {
            viewController.moviesCollectionView.reloadData()
        }
    }
    private var viewController: MoviesViewController
    var isLoadingData: Bool = false
    
    var movies: [Movie] {
        get {
            if selectedType == .top {
                return DataSingleton.instance.topMovies
            } else {
                return DataSingleton.instance.favourites
            }
        }
    }
    
    init(viewController: MoviesViewController) {
        self.viewController = viewController
        getMovies(offset: 0)
    }
    
    fileprivate func getMovies(offset: Int) {
        isLoadingData = true
        NetworkController.getTopMovies(offset: offset, completion: { (movies) in
            DataSingleton.instance.topMovies.append(contentsOf: movies)
            self.viewController.moviesCollectionView.reloadData()
            self.isLoadingData = false
        }, onError: {
            
        })
    }
    
}
