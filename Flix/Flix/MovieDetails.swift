//
//  MovieDetails.swift
//  Flix
//
//  Created by Jennifer Lopez on 10/3/20.
//  Copyright © 2020 Jennifer Lopez. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetails: UIViewController {
    
    var movie : [String:Any]!
    
    @IBOutlet weak var bigPoster: UIImageView!
    @IBOutlet weak var smallPoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        movieName.text = movie["title"] as? String
        movieName.sizeToFit()
        
        synopsis.text = movie["overview"] as? String
        synopsis.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p"
             let posterPath = movie["poster_path"] as! String
             let posterURL = URL(string: baseUrl + "/w185/"+posterPath)

            smallPoster.af.setImage(withURL: posterURL!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backURL = URL(string: baseUrl+"/w780/"+backdropPath)
        
        bigPoster.af.setImage(withURL: backURL!)

    }

}
