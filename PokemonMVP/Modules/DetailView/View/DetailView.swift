//
//  DetailView.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit
import SDWebImage

final class DetailView: UIViewController {
    
    // MARK: - UI Outlets

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let header: HeaderDetailView = {
        let view = HeaderDetailView()
        return view
    }()
    
    private let separator: Separator = {
        let view = Separator(color: .white)
        return view
    }()
    
    private let typeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let bodyHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        label.text = "Types"
        label.textColor = .white
        return label
    }()
    
    private let abilitiesHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        label.text = "Abilities"
        label.textColor = .white
        return label
    }()
    
    private let typeOneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    private let button: DetailButton = {
        let button = DetailButton(text: "Remove",
                                  color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                  insets: UIEdgeInsets(top: 5,
                                                       left: 5,
                                                       bottom: 3,
                                                       right: 5),
                                  font: UIFont.systemFont(ofSize: 19,
                                                          weight: .medium),
                                  corner: 5)
        return button
    }()
    
    private let typeTwoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    private let abilitiesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let fullBodyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let bodyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let fullTypeStck: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let fullAbilitiesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let typeSpacer = UIView()
    
    // MARK: Header constraints

    lazy var portraitHeight = header
        .heightAnchor
        .constraint(equalToConstant: view.frame.width - 32 - 200)
    lazy var portraitwidth = header
        .widthAnchor
        .constraint(equalToConstant: view.frame.width - 32)
    lazy var landscapeHeight = header
        .heightAnchor
        .constraint(equalToConstant: view.frame.height - 32 - 200)
    lazy var landscapewidth = header
        .widthAnchor
        .constraint(equalToConstant: view.frame.height - 32)
    
    ///scroll constraints
    lazy var scrollHeight = containerView
        .heightAnchor
        .constraint(equalTo: scrollView.heightAnchor)
    lazy var scrollWidth = containerView
        .widthAnchor
        .constraint(equalTo: scrollView.widthAnchor)
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    // MARK: Data

    var deleteAction: (() -> ())?
    var pokemon: Pokemon?
    
    // MARK:  Module components
    private var presenter: DetailPresenterProtocol

    // MARK: Life cycle

    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFront()
        setupFront()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setAxis()
            self.navigationItem.largeTitleDisplayMode = .always
            coordinator.animate(alongsideTransition: { (_) in
                self.navigationController?.navigationBar.sizeToFit()
            }, completion: nil)
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Front

private extension DetailView {
    
    func setInitAxis() {
        if (windowInterfaceOrientation?.isLandscape ?? false) {
            fullBodyStack.axis = .horizontal
            scrollWidth.isActive = true
            scrollHeight.isActive = false
            landscapeHeight.isActive = true
            landscapewidth.isActive = true
            portraitHeight.isActive = false
            portraitwidth.isActive = false
        } else {
            scrollWidth.isActive = false
            scrollHeight.isActive = true
            fullBodyStack.axis = .vertical
            landscapeHeight.isActive = false
            landscapewidth.isActive = false
            portraitHeight.isActive = true
            portraitwidth.isActive = true
        }
    }
    
    func setAxis() {
        if UIDevice.current.orientation.isLandscape {
            fullBodyStack.axis = .horizontal
        } else {
            fullBodyStack.axis = .vertical
        }
        view.layoutIfNeeded()
    }
    
    func setupFront() {
        let topPadding: CGFloat = 20
        let lateralPadding: CGFloat = 16
        view.backgroundColor = UIColor(named: App.Colors.main.rawValue)
        view.addSubview(scrollView)
        containerView.backgroundColor = UIColor(named: App.Colors.main.rawValue)
        scrollView.addSubview(containerView)
        containerView.addSubview(fullBodyStack)
        [header, button].forEach {
            headerStack.addArrangedSubview($0)
        }
        [headerStack, bodyStack].forEach {
            fullBodyStack.addArrangedSubview($0)
        }
        [fullTypeStck, fullAbilitiesStack].forEach {
            bodyStack.addArrangedSubview($0)
        }
        [bodyHeaderLabel, typeStack].forEach {
            fullTypeStck.addArrangedSubview($0)
        }
        [abilitiesHeaderLabel, abilitiesStack].forEach {
            fullAbilitiesStack.addArrangedSubview($0)
        }
        typeStack.addArrangedSubview(typeOneLabel)
        setInitAxis()
        header.anchor(topAnchor: headerStack.topAnchor,
                      trailingAnchor: headerStack.trailingAnchor,
                      bottomAnchor: nil,
                      leadingAnchor: headerStack.leadingAnchor)
        scrollView.anchor(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                          trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor,
                          bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                          leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor)
        containerView.anchor(topAnchor: scrollView.topAnchor,
                             trailingAnchor: scrollView.trailingAnchor,
                             bottomAnchor: scrollView.bottomAnchor,
                             leadingAnchor: scrollView.leadingAnchor)
        fullBodyStack.anchor(topAnchor: containerView.topAnchor,
                             trailingAnchor: containerView.trailingAnchor,
                             bottomAnchor: containerView.bottomAnchor,
                             leadingAnchor: containerView.leadingAnchor,
                             padding: .init(top: topPadding,
                                            left: lateralPadding,
                                            bottom: topPadding,
                                            right: lateralPadding))
        scrollWidth.priority = .defaultLow
        scrollHeight.priority = .defaultLow
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            typeTwoLabel.heightAnchor.constraint(equalToConstant: 50),
            typeOneLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        button.addTarget(self, action: #selector(onDeletePokemon(_:)), for: .touchUpInside)
    }
}

// MARK: - Inner

private extension DetailView {
    
    func populateFront() {
        guard let pokemon = pokemon else { return }
        let number = "#" + String(pokemon.order)
        let name = pokemon.name
        title = name
        header.nameLabel.text = number + " " + name
        button.setTitle("Remove " + name, for: .normal)
        header.imageView.sd_setImage(with: URL(string: pokemon.sprites?.frontDefault ?? ""),
                                     placeholderImage: UIImage(named: "placeholder.png"))
        setTypesSegment()
        setAbilitiesSegment()
    }
    
    func setTypesSegment() {
        guard let pokemon = pokemon else { return }
        let types = presenter.returnTypes(pokemon: pokemon)
        if let mainType = types.first {
            typeOneLabel.text = mainType.rawValue
            typeOneLabel.backgroundColor = UIColor(named: mainType.returnTypeColor().rawValue)
        }
        if let secondType = types.last, (types.count) == 2 {
            typeStack.addArrangedSubview(typeTwoLabel)
            typeTwoLabel.text = secondType.rawValue
            typeTwoLabel.backgroundColor = UIColor(named: secondType.returnTypeColor().rawValue)
        }
    }
    
    func setAbilitiesSegment() {
        guard let pokemon = pokemon else { return }
        let abilities = presenter.returnAbilitiesNames(pokemon: pokemon)
        abilities.forEach {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .white
            label.text = "- " + $0
            abilitiesStack.addArrangedSubview(label)
        }
        abilitiesStack.addArrangedSubview(UIView())
    }
}

// MARK: - Actions

private extension DetailView {
    
    @objc func onDeletePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        presenter.removePokemon(name: pokemon.name)
    }
}

// MARK: - View

extension DetailView: DetailViewProtocol {
    
}

#if DEBUG

import SwiftUI

struct Preview: PreviewProvider {
    
    static var previews: some View {
        let router = DetailRouter()
        let vc = DetailView(presenter: DetailPresenter(router: router))
        return Group {
            vc.view.instaView.edgesIgnoringSafeArea(.all)
            vc.view.instaView.edgesIgnoringSafeArea(.all)
        }
    }
}

#endif

