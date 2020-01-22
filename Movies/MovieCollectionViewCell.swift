//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by curs on 1/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    var delegate: UICollectionViewLongPressDelegate!
    var indexPath: IndexPath!
    
    func setMovie(_ movie: Movie) {
        movieImage.kf.setImage(with: URL(string: movie.image!))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(MovieCollectionViewCell.onLongPress))
        self.addGestureRecognizer(longTap)
    }
    
    @objc private func onLongPress(){
        delegate.onLongPress(indexPath: indexPath)
    }
    
    override func prepareForReuse() {
        for gesture in self.gestureRecognizers!{
            self.removeGestureRecognizer(gesture)
        }
    }
}
