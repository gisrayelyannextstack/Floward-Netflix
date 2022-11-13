//
//  MovieCollectionCell.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 14.11.22.
//

import UIKit
import Kingfisher

class MovieCollectionCell: UICollectionViewCell {
    // MARK: - Views
    
    private var containerView: UIView!
    private var movieImageView: UIImageView!
    private var movieTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieTitleLabel.text = nil
    }
    
    // MARK: - Publis methods
    
    func setData(_ movie: Movie) {
        movieTitleLabel.text = movie.title
        movieImageView.kf.setImage(with: movie.posterUrl, placeholder: UIImage(named: "placeholder_icon"))
    }
}

// MARK: - SetupUI

extension MovieCollectionCell {
    func setupUI() {
        setupContainerView()
        setupImageView()
        setupTitleLabel()
    }
    
    // MARK: Setup container view
    func setupContainerView() {
        containerView = UIView(frame: .zero)
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .appBackground
        containerView.applyShadow()
        containerView.layer.cornerRadius = 8
        
        containerView.pinEdgesToSuperView(xMargin: 2, yMargin: 2)
    }
    
    // MARK: Setup image view
    func setupImageView() {
        movieImageView = UIImageView(frame: .zero)
        containerView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 8
        movieImageView.contentMode = .scaleAspectFill
        
        movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    // MARK: Setup title label
    func setupTitleLabel() {
        movieTitleLabel = UILabel(frame: .zero)
        containerView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieTitleLabel.textColor = .textPrimaryColor
        movieTitleLabel.font = UIFont(name: "Helvetica", size: 14)
        
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8).isActive = true
        movieTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
    }
}
