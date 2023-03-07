//
//  DetailsViewController.swift
//  YourMovie
//
//  Created by Kripa Lamichhane on 3/5/23.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    
    @IBOutlet weak var Details: UITextView!
    
  
   
    @IBOutlet weak var Ratings: UILabel!
    var movie:MovieReview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieName.text = movie?.original_title
        Details.text = movie?.overview
        let urlString = "https://api.themoviedb.org" + (movie?.poster_path)!
        let url = URL(string : urlString)
        backgroundImage.downloaded(from: url!)
        

    }
    

}
