//
//  CarouselViewController.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 09/08/2024.
//

import UIKit

class CarouselViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    var slides:[Slide] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScrollView()
        layoutView()
        setupSlides()
        setupPageControl()
        addButtonActions() // Add actions to buttons
    }

    func setupView() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.backgroundColor = UIColor.white
    }

    func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
    }

    func setupSlides() {
        slides = createSlides()
        setupSlideScrollView(slides: slides)
    }

    func setupPageControl() {
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    func layoutView() {
        layoutScrollView()
        layoutPageControl()
    }

    func layoutScrollView() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    func layoutPageControl() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.3),
            pageControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
    }

    func addButtonActions() {
        for slide in slides {
            slide.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            slide.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
    }

    @objc func nextButtonTapped() {
        let currentPage = pageControl.currentPage
        if currentPage < slides.count - 1 {
            let nextPage = currentPage + 1
            let offset = CGPoint(x: scrollView.frame.width * CGFloat(nextPage), y: 0)
            scrollView.setContentOffset(offset, animated: true)
        } else {
            redirectToNewPage()
        }
    }

    @objc func backButtonTapped() {
        let currentPage = pageControl.currentPage
        if currentPage < slides.count - 1 {
            let previousPage = currentPage - 1
            let offset = CGPoint(x: scrollView.frame.width * CGFloat(previousPage), y: 0)
            scrollView.setContentOffset(offset, animated: true)
        } else {
            dismissCarousel()
        }
    }

    func redirectToNewPage() {
        let viewController = ViewController()
        let sfSymbolsViewController = SFSymbolsViewController()
        navigationController?.viewControllers = [viewController, sfSymbolsViewController]
        self.updateLastVersionInUserDefaults()
    }

    func dismissCarousel() {
        let viewController = ViewController()
        navigationController?.viewControllers = [viewController]
        self.updateLastVersionInUserDefaults()
    }

    private func updateLastVersionInUserDefaults() {
        if let currentVersion = AppData.shared.currentVersion {
            UserDefaults.standard.setValue(currentVersion, forKey: "LastAppVersion")
        }
    }
}

extension CarouselViewController {

    func createSlides() -> [Slide] {

        let slide1: Slide = Slide()
        slide1.imageView.image = UIImage(systemName: "car")
        slide1.labelTitle.text = "Car"
        slide1.labelDesc.text = "Represents a filled car, ideal for illustrating themes related to transportation or vehicles."

        let slide2: Slide = Slide()
        slide2.imageView.image = UIImage(systemName: "heart")
        slide2.labelTitle.text = "Heart"
        slide2.labelDesc.text = "A filled heart symbolizing love, health, or favorite "

        let slide3: Slide = Slide()
        slide3.imageView.image = UIImage(systemName: "star")
        slide3.labelTitle.text = "Star"
        slide3.labelDesc.text = "A filled star often used to represent favorites or achievements."

        let slide4: Slide = Slide()
        slide4.imageView.image = UIImage(systemName: "sun.max")
        slide4.labelTitle.text = "Sun"
        slide4.labelDesc.text = "A filled sun symbol, commonly used to indicate brightness or weather."

        let slide5: Slide = Slide()
        slide5.imageView.image = UIImage(systemName: "house")
        slide5.labelTitle.text = "House"
        slide5.labelDesc.text = "Represents a filled house, often associated with themes of homes and real estate."

        return [slide1, slide2, slide3, slide4, slide5]
    }

    func setupSlideScrollView(slides : [Slide]) {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
            
            // Configuração inicial da imagem
            slides[i].imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            // Animação de pulse
            UIView.animate(withDuration: 1.0,
                          delay: 0.2,
                          usingSpringWithDamping: 0.5,
                          initialSpringVelocity: 0.5,
                          options: .curveEaseInOut,
                          animations: {
                slides[i].imageView.transform = .identity
            }, completion: nil)
        }
    }
}

extension CarouselViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        let currentOffset = scrollView.contentOffset.x
        let currentPage = Int(currentOffset / pageWidth)
        
        // Updates the pageControl
        pageControl.currentPage = currentPage
        
        // Ensures we have a next page to animate
        guard currentPage < slides.count - 1 else { return }
        
        // Calculates scroll progress (0 to 1)
        let progress = (currentOffset - (pageWidth * CGFloat(currentPage))) / pageWidth
        
        // Calculates scales (now from 1.0 to 0.2 and from 0.2 to 1.0)
        let currentScale = max(0.2, 1 - (0.8 * progress))
        let nextScale = min(1, 0.2 + (0.8 * progress))
        
        // Applies transformations
        if currentPage >= 0 && currentPage < slides.count {
            slides[currentPage].imageView.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
        
        // Button logic
        if currentPage + 1 < slides.count {
            slides[currentPage + 1].imageView.transform = CGAffineTransform(scaleX: nextScale, y: nextScale)
        }
        
        if currentPage == 0 {
            slides[currentPage].showBackButton(false)
        } else {
            slides[currentPage].showBackButton(true)
        }
        
        if currentPage == slides.count - 1 {
            slides[currentPage].setTitleNextButton("start")
            slides[currentPage].setTitleBackButton("dismiss")
        }
    }

    /**
     The system calls this method when the iOS interface environment changes.
     When we rotate the device, the frame of the UIScrollView is recreated, so we need to recreate the slides in that case.
     */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
}


