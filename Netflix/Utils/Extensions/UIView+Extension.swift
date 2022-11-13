//
//  UIView+Extension.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import UIKit

// MARK: - Shadow
extension UIView {
    func applyShadow(color: UIColor = .black.withAlphaComponent(0.2), x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
    }
}

// MARK: - Constraint

extension UIView {
    @discardableResult
    func addRatioConstraint(multiplayer: CGFloat = 1, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: multiplayer, constant: 0)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    func pinEdgesToSuperView(xMargin: CGFloat = 0, yMargin: CGFloat = 0) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: yMargin).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor, constant: xMargin).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -xMargin).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -yMargin).isActive = true
    }
    
    func pinCenterToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    func pinEdgesToSuperViewSafeXMargin(xMargin: CGFloat = 0, yMargin: CGFloat = 0) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: yMargin).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -yMargin).isActive = true
        leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: xMargin).isActive = true
        rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: -xMargin).isActive = true
    }
}
