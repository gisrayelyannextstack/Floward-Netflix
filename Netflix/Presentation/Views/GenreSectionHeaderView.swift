//
//  GenreSectionHeaderView.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 14.11.22.
//

import UIKit

class GenreSectionHeaderView: UICollectionReusableView {
    // MARK: - Views
    
    private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard")
    }
    
    // MARK: - Public methods
    
    func setData(_ title: String) {
        textLabel.text = title
    }
}

// MARK: - SetupUI

private extension GenreSectionHeaderView {
    func setupUI() {
        textLabel = UILabel(frame: .zero)
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.textColor = .textPrimaryColor
        textLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        
        textLabel.pinEdgesToSuperView()
    }
}
