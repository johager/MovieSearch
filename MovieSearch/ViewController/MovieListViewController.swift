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
        view.backgroundColor = .red
        print("\(#function) - apiKey: \(movieController.apiKey)")
    }

    // MARK: - View Methods
    
    func setUpViews() {
        tableView.dataSource = self
    }
    
    // MARK: - Actions
}

// MARK: -

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
