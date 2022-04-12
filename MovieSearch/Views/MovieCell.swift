//
//  MovieCell.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import UIKit

class MovieCell: UITableViewCell {

    // MARK: - Views
    
    var posterImageView: UIImageView!
    var titleLabel: UILabel!
    var releaseDateLabel: UILabel!
    var ratingLabel: UILabel!
    var overviewLabel: UILabel!
    
    
    // MARK: - Methods
    
    func configure(with movie: Movie) {
        setUpViews()
        
        if let posterPath = movie.posterPath {
            getPosterImage(for: posterPath)
        }
        
        posterImageView.image = UIImage(systemName: "photo")?.withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        
        var titleString = movie.title
        if let originalTitle = movie.originalTitle, originalTitle != movie.title {
            titleString += "\n(\(originalTitle))"
        }
        titleLabel.text = titleString
        
        releaseDateLabel.text = "Released: \(dateString(from: movie.releaseDateString))"
        
        if let rating = movie.rating {
            ratingLabel.text = "Rating: \(String(format: "%.1f", rating))"
        } else {
            ratingLabel.text = "Rating: NA"
        }
        
        overviewLabel.text = movie.overview
    }
    
    func setUpViews() {
        guard posterImageView == nil else { return }
        
        selectionStyle = .none
        
        let layoutMarginsGuide = contentView.layoutMarginsGuide
        
        let mainStackView = UIStackView()
        contentView.addSubview(mainStackView)
        mainStackView.pin(top: layoutMarginsGuide.topAnchor, trailing: layoutMarginsGuide.trailingAnchor, bottom: layoutMarginsGuide.bottomAnchor, leading: layoutMarginsGuide.leadingAnchor)
        
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .top
        mainStackView.spacing = 8
        
        posterImageView = UIImageView()
        mainStackView.addArrangedSubview(posterImageView)
        
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5).isActive = true
        
        let rStackView = UIStackView()
        mainStackView.addArrangedSubview(rStackView)
        
        rStackView.axis = .vertical
        rStackView.distribution = .fill
        rStackView.alignment = .leading
        rStackView.spacing = 6
        rStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = label(textStyle: .headline)
        rStackView.addArrangedSubview(titleLabel)
        
        releaseDateLabel = label(textStyle: .footnote)
        rStackView.addArrangedSubview(releaseDateLabel)
        
        ratingLabel = label(textStyle: .footnote)
        rStackView.addArrangedSubview(ratingLabel)
        
        overviewLabel = label(textStyle: .footnote)
        rStackView.addArrangedSubview(overviewLabel)
    }
            
    func label(textStyle: UIFont.TextStyle, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func dateString(from dateString: String?) -> String {
        guard let dateString = dateString,
              !dateString.isEmpty
        else { return "NA" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getPosterImage(for posterPath: String) {
        MovieController.getPoster(for: posterPath) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posterImage):
                    self.posterImageView.image = posterImage
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
