//
//  ViewController.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 08/08/2024.
//

import UIKit

class ViewController: UIViewController {

    lazy var helloWorldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Hello World"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(helloWorldLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloWorldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helloWorldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
