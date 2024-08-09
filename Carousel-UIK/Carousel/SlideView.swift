//
//  SlideView.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 09/08/2024.
//

import UIKit

class Slide: UIView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var labelTitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = .boldSystemFont(ofSize: 20)
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    lazy var labelDesc: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("back", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 4
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var goToButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        self.addSubview(imageView)
        self.addSubview(labelTitle)
        self.addSubview(labelDesc)
        self.addSubview(nextButton)
        self.addSubview(backButton)
        self.backgroundColor = UIColor.white
    }

    private func layoutViews() {
        layoutImageView()
        layoutLabelTitle()
        layoutLabelDesc()
        layoutNextButton()
        layoutBackButton()
    }

    private func layoutImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 55),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    private func layoutLabelTitle() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }

    private func layoutLabelDesc() {
        NSLayoutConstraint.activate([
            labelDesc.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            labelDesc.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func layoutNextButton() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func layoutBackButton() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    public func showBackButton(_ value: Bool) {
        backButton.isHidden = value == true ? false : true
    }

    public func setTitleNextButton(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }

    public func setTitleBackButton(_ title: String) {
        backButton.setTitle(title, for: .normal)
    }
}


