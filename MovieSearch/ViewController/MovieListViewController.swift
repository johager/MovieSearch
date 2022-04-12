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
    var segmentedControl: UISegmentedControl!
    var tableView: UITableView!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    // MARK: - View Methods
    
    func setUpViews() {
        title = "Movie Search"
        
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.pin(top: safeArea.topAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor)
        
        searchBar.placeholder = "Movie title..."
        searchBar.delegate = self
        
        let sortView = UIView()
        view.addSubview(sortView)
        sortView.pin(top: searchBar.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor, margin: [-2, 0, 0, 0])
        sortView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        segmentedControl = UISegmentedControl(items: ["Title", "Release Date", "Rating"])
        sortView.addSubview(segmentedControl)
        segmentedControl.pin(top: sortView.topAnchor, trailing: nil, bottom: sortView.bottomAnchor, leading: nil, margin: [2, 0, 11, 0])
        segmentedControl.centerXAnchor.constraint(equalTo: sortView.centerXAnchor).isActive = true
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        let border = UIView()
        sortView.addSubview(border)
        border.pin(top: nil, trailing: sortView.trailingAnchor, bottom: sortView.bottomAnchor, leading: sortView.leadingAnchor)
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        border.backgroundColor = UIColor(white: 177/255, alpha: 1)
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.pin(top: sortView.bottomAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
    }
    
    func updateViews(movies: [Movie]) {
        self.movies = movies
        sortMovies()
    }
    
    // MARK: - Misc Methods
    
    func getMovies(withTitle title: String) {
        movieController.getMovies(withTitle: title) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    //print(movies)
                    self.updateViews(movies: movies)
                case .failure(let error):
                    self.presentErrorAlert(for: error)
                }
            }
        }
    }
    
    func sortMovies() {
        guard let index = segmentedControl?.selectedSegmentIndex,
              movies.count > 0
        else { return }
        
        switch index {
        case 0:
            movies.sort { $0.title < $1.title}
        case 1:
            movies.sort {(lhs: Movie, rhs: Movie) -> Bool in
                guard let lhs = lhs.releaseDateString, let rhs = rhs.releaseDateString else { return false }
                return lhs < rhs
            }
        case 2:
            movies.sort { (lhs: Movie, rhs: Movie) -> Bool in
                guard let lhs = lhs.rating, let rhs = rhs.rating else { return false }
                return lhs > rhs
            }
        default:
            break
        }
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        sortMovies()
    }
}

// MARK: - UISearchBarDelegate

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              !text.isEmpty
        else { return }
        getMovies(withTitle: text)
    }
}

// MARK: - UITableViewDataSource

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
