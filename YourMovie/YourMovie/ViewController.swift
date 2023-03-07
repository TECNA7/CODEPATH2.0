//
//  ViewController.swift
//  YourMovie
//
//  Created by Kripa Lamichhane on 3/4/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as!DetailsTableViewCell
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyy"
        let date = inputFormatter.date(from: movies[indexPath.row].release_date)
        let dateString = outputFormatter.string(from: date!)
        DispatchQueue.main.async {
            cell.titleLabel.text = self.movies[indexPath.row].release_date
            cell.releaseDate.text = dateString
        }
        print(movies[indexPath.row].release_date)
        let path = URL(string: "https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        print("https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        URLSession.shared.dataTask(with: path!) {
            (data, response, error) in
            guard
                let data = data
            else {
                return
            }
            DispatchQueue.main.async {
                cell.movieImage.image = UIImage(data: data)
            }
        }.resume()
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details: DetailsViewController = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as!DetailsViewController
        navigationController?.pushViewController(details, animated: true)
        
        let path = URL(string: "https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        URLSession.shared.dataTask(with: path!) {
            (data, response, error) in
            guard
                let data = data
            else {
                return
            }
            DispatchQueue.main.async {
                details.backgroundImage.image = UIImage(data: data)
            }
        }.resume()
        
        DispatchQueue.main.async {
            details.movieName.text = self.movies[indexPath.row].original_title
            details.Details.text = self.movies[indexPath.row].overview
            details.Ratings.text = String(self.movies[indexPath.row].vote_average / 2)
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "YYYY-MM-dd"
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyy"
            let date = inputFormatter.date(from: self.movies[indexPath.row].release_date)
            let dateString = outputFormatter.string(from: date!)
            details.Date.text = dateString
        }
        
    }
    
  /**
    func myTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func myTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as!DetailsTableViewCell
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyy"
        let date = inputFormatter.date(from: movies[indexPath.row].release_date)
        let dateString = outputFormatter.string(from: date!)
        DispatchQueue.main.async {
            cell.titleLabel.text = self.movies[indexPath.row].release_date
            cell.releaseDate.text = dateString
        }
        print(movies[indexPath.row].release_date)
        let path = URL(string: "https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        print("https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        URLSession.shared.dataTask(with: path!) {
            (data, response, error) in
            guard
                let data = data
            else {
                return
            }
            DispatchQueue.main.async {
                cell.movieImage.image = UIImage(data: data)
            }
        }.resume()
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details: DetailsViewController = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as!DetailsViewController
        navigationController?.pushViewController(details, animated: true)
        
        let path = URL(string: "https://image.tmdb.org/t/p/original\(movies[indexPath.row].poster_path)")
        URLSession.shared.dataTask(with: path!) {
            (data, response, error) in
            guard
                let data = data
            else {
                return
            }
            DispatchQueue.main.async {
                details.backgroundImage.image = UIImage(data: data)
            }
        }.resume()
        
        DispatchQueue.main.async {
            details.movieName.text = self.movies[indexPath.row].original_title
            details.Details.text = self.movies[indexPath.row].overview
            details.Ratings.text = String(self.movies[indexPath.row].vote_average / 2)
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "YYYY-MM-dd"
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyy"
            let date = inputFormatter.date(from: self.movies[indexPath.row].release_date)
            let dateString = outputFormatter.string(from: date!)
            details.Date.text = dateString
        }
        
    }
    */
    
    
    
    /**  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return movies.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
     cell.textLabel?.text = movies[indexPath.row].original_title.capitalized
     return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     performSegue(withIdentifier: "showDetails", sender: self)
     } */
    @IBOutlet weak var myTableView: UITableView!
    var movies = [MovieReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson {
            self.myTableView.reloadData()
        }
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
       guard gestureRecognizer.view != nil else { return }
            
       if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
          let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
             gestureRecognizer.view!.center.x += 100
             gestureRecognizer.view!.center.y += 100
          })
          animator.startAnimation()
       }}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? DetailsViewController{
            destination.movie = movies[myTableView.indexPathForSelectedRow!.row ]
        }
    }
    func downloadJson(completed: @escaping ()  -> ()){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard
                let data = data
            else {
                return
            }
            if error == nil {
                do{
                    self.movies = try JSONDecoder().decode([MovieReview].self,from: data)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
    
    
}
