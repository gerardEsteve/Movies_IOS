//
//  DetailsViewController.swift
//  Movies
//
//  Created by curs on 4/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var heartImatge: UIImageView!
    @IBOutlet weak var filmImatge: UIImageView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceLabel.text = movie.price
        titleLabel.text = movie.title
        categoryLabel.text = movie.category
        durationLabel.text = movie.duration
        directorLabel.text = movie.director
        summaryTextView.text = movie.summary
        filmImatge.kf.setImage(with: URL(string: movie.image!))
        
        filmImatge.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.doubleTap))
        tapGesture.numberOfTapsRequired = 2
        filmImatge.addGestureRecognizer(tapGesture)
                
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 225, height: 35))
        toastLabel.backgroundColor = UIColor.lightGray
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    

    @objc func doubleTap() {
        let boolContains: Bool = DataSingleton.instance.favourites.contains(where: { (m) -> Bool in
            return m.title == movie.title
        })
        if !boolContains {
            BigLikeAnimation.start(likeImage: heartImatge)
            DataSingleton.instance.favourites.append(movie)
            showToast(message: "Movie added to favourites.  ")

        }
    }
}

extension Equatable {
    
}
