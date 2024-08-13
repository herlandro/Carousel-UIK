//
//  SFSymbolsViewController.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 13/08/2024.
//

import Foundation

import UIKit

class SFSymbolsViewController: UIViewController {

    let sfSymbols = [
        "house", "heart", "star", "bell", "camera", "gear", "bookmark",
        "bolt", "pencil", "clock", "mic", "sun.max", "moon", "cloud",
        "flame", "drop", "leaf", "cart", "gift", "car", "airplane",
    ]

    // Definir o número de colunas desejadas
    let numberOfColumns: CGFloat = 4


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemWidth = (view.frame.width - (numberOfColumns + 1) * spacing) / numberOfColumns
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SFSymbolCell.self, forCellWithReuseIdentifier: "SFSymbolCell")
        view.addSubview(collectionView)
    }
}

extension SFSymbolsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sfSymbols.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SFSymbolCell", for: indexPath) as! SFSymbolCell
        let symbolName = sfSymbols[indexPath.item]
        cell.configure(symbolName: symbolName)
        return cell
    }
}

class SFSymbolCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(symbolName: String) {
        imageView.image = UIImage(systemName: symbolName)
        label.text = symbolName
    }
}

