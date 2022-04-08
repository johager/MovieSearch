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
    
    var searchBar: UISearchBar!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getMovies(withTitle: "Star Trek")
    }

    // MARK: - View Methods
    
    func setUpViews() {
        title = "Movie Search"
        
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.pin(top: safeArea.topAnchor, trailing: safeArea.trailingAnchor, bottom: nil, leading: safeArea.leadingAnchor)
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.pin(top: searchBar.bottomAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
    }
    
    func updateViews(movies: [Movie]) {
        title = "Movies"
        self.movies = movies
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    func getMovies(withTitle title: String) {
        movieController.getMovies(withTitle: title) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    print(movies)
                    self.updateViews(movies: movies)
                case .failure(let error):
                    print(error)
                    self.presentErrorAlert(for: error)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell
        else { return UITableViewCell() }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}
