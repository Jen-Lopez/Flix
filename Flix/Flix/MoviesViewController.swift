//  MoviesViewController.swift
//  Flix
//  Created by Jennifer Lopez on 9/24/20.

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        
            self.movies = dataDictionary["results"] as! [[String: Any]]
            
            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movieTitle =  movies[indexPath.row]["title"] as! String
        let movieSynopsis = movies[indexPath.row]["overview"] as! String
        
        movieCell.title.text = movieTitle
        movieCell.synopsis.text = movieSynopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185/"
        let posterPath = movies[indexPath.row]["poster_path"] as! String
        let posterURL = URL(string: baseUrl+posterPath)
        movieCell.posterImage.af.setImage(withURL: posterURL!)
        
        return movieCell
    }
    
    // prepares the next screen, sends data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cellSender = sender as! UITableViewCell
        let index = tableView.indexPath(for: cellSender)!
        let currMovie = movies[index.row]
        
        let detailsVC = segue.destination as! MovieDetails
        detailsVC.movie = currMovie
        
        tableView.deselectRow(at: index, animated: true)
    }

}
