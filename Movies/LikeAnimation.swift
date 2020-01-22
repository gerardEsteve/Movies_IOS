
import UIKit

protocol LikeAnimation {
    static func fadeOut(likeView: UIImageView)
}

extension LikeAnimation {
    
    static var bigTransForm: CGAffineTransform {
        return CGAffineTransform(scaleX: 1.4, y: 1.4)
    }
    
    
    static var normalTransForm: CGAffineTransform {
        return CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
    
    
    static var smallTransForm: CGAffineTransform {
        return CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    //Animaciones:
    
    static func start(likeImage: UIImageView) {
        likeImage.isHidden = false
        bigSizeIncrease(likeView: likeImage)
    }
    
    
    
    // Hacemos grande
    static func bigSizeIncrease(likeView: UIImageView) {
        UIView.animate(withDuration: 0.3, animations: {
            likeView.alpha = 1
            likeView.transform = bigTransForm
        }, completion: { _ in
            turnNormalSize(likeView: likeView, fadeOutNext: false)
        })
    }
    
    // Volvemos al tamaño normal
    static func turnNormalSize(likeView: UIImageView, fadeOutNext: Bool) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = normalTransForm
        }, completion: { _ in
            if fadeOutNext { // Si es true ocultamos y paramos la animacion
                fadeOut(likeView: likeView)
            } else { // En caso contrario seguimos animando
                smallSizeIncrese(likeView: likeView)
            }
        })
    }
    
    // Pequeño incremento
    static func smallSizeIncrese(likeView: UIImageView) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = smallTransForm
        }, completion: { _ in
            turnNormalSize(likeView: likeView, fadeOutNext: true)
        })
    }
}

class BigLikeAnimation: LikeAnimation {
    static var fadeOutTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    
    static func fadeOut(likeView: UIImageView) {
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            likeView.transform = fadeOutTransform
            likeView.alpha = 0
        }, completion: { _ in
            likeView.transform = normalTransForm
            likeView.isHidden = true
        })
    }
}

