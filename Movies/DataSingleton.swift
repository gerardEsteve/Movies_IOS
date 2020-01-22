
class DataSingleton {
    var topMovies = [Movie]()
    var favourites: [Movie]! = [Movie]()
    
    static let instance = DataSingleton()
    
    private init() {}

}
