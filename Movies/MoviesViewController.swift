import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    fileprivate var cellWidth: Double!
    fileprivate var viewModel: MovieViewModel!
    
    var longHandler: ((_ indexPath: IndexPath) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieViewModel(viewController: self)
        
        setCellWidth()
        longHandler = topLongHandler
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    // Gestiona la navegacio de la vista cap a altres
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail" {
            let lastClickedIndex = moviesCollectionView.indexPathsForSelectedItems![0]
            let movieDetail = segue.destination as! DetailsViewController
            movieDetail.movie = viewModel.movies[lastClickedIndex.row]
            
        }
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
    
    
    @IBAction func segmentedControlValueChanged(_ sender:
        UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.selectedType = .top
            longHandler = topLongHandler
        case 1:
            viewModel.selectedType = .fav
            longHandler = favLongHandler
        default:
            print("default")
        }
    }
    
    func favLongHandler(_ indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "Delete from Favourites", message: "Are you sure you want to delete this film from favourites?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: { (_)
            in
            self.moviesCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Delete", style: .destructive, handler: { (_)
            in
            DataSingleton.instance.favourites.remove(at: indexPath.item)
            self.moviesCollectionView.reloadData()
        }))
        
       
        self.present(alert, animated: true, completion: nil)
    }
    
    func topLongHandler(_ indexPath: IndexPath) {
        let boolContains: Bool = DataSingleton.instance.favourites.contains(where: { (m) -> Bool in
            return m.title == self.viewModel.movies[indexPath.row].title
        })
        if !boolContains {
            let alert = UIAlertController.init(title: "Add Favourites", message: "Are you sure you want to add this film to favourites?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: { (_)
                in
                self.moviesCollectionView.reloadData()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Add", style: .default, handler: { (_)
                in
                DataSingleton.instance.favourites.append(self.viewModel.movies[indexPath.row])
                self.moviesCollectionView.reloadData()
                self.showToast(message: "Movie added to favourites.  ")

            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert2 = UIAlertController.init(title: "Already Favourite", message: "This film is already in the favourite list", preferredStyle: .alert)
            
            alert2.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_)
                in
                self.moviesCollectionView.reloadData()
            }))
            
            self.present(alert2, animated: true, completion: nil)
            
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewLongPressDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetail", sender: nil)
    }
    
    func onLongPress(indexPath: IndexPath){
        
        longHandler(indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setMovie(viewModel.movies[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: (cellWidth * 6) / 4)
    }
    
    func setCellWidth() {
        let flow = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let f = self.view.frame.width
        let width = (f - (flow.sectionInset.right + flow.sectionInset.left) * 2) / 3
        
        self.cellWidth = Double(width) - 1
    }
    
    
}
