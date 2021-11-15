//
//  PokemonTableViewCell.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class PokemonTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        populateFront()
        setupFront()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pokemonName: String = "Default" {
        didSet {
            populateFront()
        }
    }
    
    private let containerView: ShadowView = {
        let view = ShadowView()
        view.cornerRadius = 10
        view.shadowColor = .white
        view.shadowOffsetHeight = 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .white
        label.text = "Default name"
        label.textAlignment = .left
        return label
    }()
    
    /// A size suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 400, height: 100)
    }
}

//MARK: - Inner

private extension PokemonTableViewCell {

    func populateFront() {
        titleLabel.text = pokemonName
    }
}

//MARK: - View setup

private extension PokemonTableViewCell {
    
    func setupFront() {
        selectionStyle = .none
        layoutSetup()
    }
    
    func layoutSetup() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        backgroundColor = UIColor(named: App.Colors.main.rawValue)
        containerView.backgroundColor = UIColor(named: App.Colors.cell.rawValue)
        titleLabel.anchor(topAnchor: containerView.topAnchor,
                          trailingAnchor: nil,
                          bottomAnchor: containerView.bottomAnchor,
                          leadingAnchor: containerView.leadingAnchor,
                          padding: .init(top: 16,
                                         left: 16,
                                         bottom: 16,
                                         right: .zero))
        containerView.anchor(topAnchor: topAnchor,
                             trailingAnchor: trailingAnchor,
                             bottomAnchor: bottomAnchor,
                             leadingAnchor: leadingAnchor,
                             padding: .init(top: 8,
                                            left: 16,
                                            bottom: 8,
                                            right: 16))
    }
}
