//
//  HomeController.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import UIKit
import Combine

class HomeController: UIViewController {
    
    // MARK: - Views
    
    private var collectionView: UICollectionView!
    private var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startup()
    }

    // MARK: - Private methods
    
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let sectionInset = 12.0
        let itemInset = 4.0
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionInset, leading: sectionInset, bottom: sectionInset, trailing: sectionInset)
        section.orthogonalScrollingBehavior = .continuous
        
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Setup

private extension HomeController {
    func setup() {
        setupCollectionView()
        setupActivityIndicatorView()
        
        title = "NETFLIX"
        view.backgroundColor = .appBackground
    }
    
    // MARK: setup collection view
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .appBackground
        
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.register(GenreSectionHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "GenreSectionHeaderView")
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: Setup activity indicator
    func setupActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.tintColor = .white
        activityIndicatorView.color = .white
        activityIndicatorView.style = .large
        
        activityIndicatorView.pinCenterToSuperView()
    }
}

// MARK: - Startup

private extension HomeController {
    func startup() {
        setupBindings()
        
        viewModel.getData()
    }
    
    // MARK: Setup Bindings
    
    func setupBindings() {
        viewModel.$genres
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &disposeBag)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                self?.activityIndicatorView.isHidden = !isLoading
            }
            .store(in: &disposeBag)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.genres[section].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.setData(viewModel.genres[indexPath.section].movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case "header":
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GenreSectionHeaderView", for: indexPath) as? GenreSectionHeaderView else {
                return GenreSectionHeaderView(frame: .zero)
            }
            headerView.setData(viewModel.genres[indexPath.row].title)
            return headerView
        default:
            assertionFailure("Unexpected element kind: \(kind).")
            return UICollectionReusableView()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
}
