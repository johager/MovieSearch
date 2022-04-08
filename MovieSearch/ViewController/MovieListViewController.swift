//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    var movies = [Movie]()
    
    let movieController = MovieController()
    
    let cellIdentifier = "movieCell"
    
    // MARK: - Views
    
    var searchBar: UISearchController!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getMovies(withTitle: "Star Trek")
    }

    // MARK: - View Methods
    
    func setUpViews() {
        //tableView.dataSource = self
        
        view.backgroundColor = .red
    }
    
    // MARK: - Actions
    
    func getMovies(withTitle title: String) {
        movieController.getMovies(withTitle: title) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    print(movies)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: -

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
