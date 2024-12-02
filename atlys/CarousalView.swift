//
//  CarousalViewController.swift
//  atlys
//
//  Created by Emmanuel Biju on 25/11/24.
//

import UIKit

class CarouselView: UIView {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.decelerationRate = .fast
        return sv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .lightGray
        pc.isUserInteractionEnabled = true
        return pc
    }()
    
    private var cardViews: [UIView] = []
    private let cardWidth: CGFloat = UIScreen.main.bounds.width - 120
    private let cardHeight: CGFloat = 250
    private let minimumScale: CGFloat = 0.8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Setup ScrollView
        addSubview(scrollView)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup PageControl
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 260),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1), // Reduced from -20 to -8
            pageControl.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    func configure(with images: [UIImage]) {
        cardViews.forEach { $0.removeFromSuperview() }
        cardViews.removeAll()
        
        // Configure PageControl
        pageControl.numberOfPages = images.count
        pageControl.currentPage = images.count / 2
        
        // Add new cards
        for (index, image) in images.enumerated() {
            let cardView = createCardView(with: image)
            scrollView.addSubview(cardView)
            cardViews.append(cardView)
            
            let overlap: CGFloat = 30
            cardView.frame = CGRect(
                x: CGFloat(index) * (cardWidth - overlap) + 60,
                y: 15,
                width: cardWidth,
                height: cardHeight
            )
            
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cardView.layer.shadowRadius = 8
        }
        
        let contentWidth = (cardWidth - 30) * CGFloat(images.count - 1) + cardWidth + 80
        scrollView.contentSize = CGSize(width: contentWidth, height: cardHeight)
        
        // Center vertically with adjusted spacing
        let scrollViewHeight = frame.height - 36 // Adjusted for page control
        scrollView.frame = CGRect(x: 0, y: (scrollViewHeight - cardHeight) / 2, width: frame.width, height: cardHeight)
        
        // Scroll to the middle card
        DispatchQueue.main.async {
            let overlap: CGFloat = 30
            let middleCardIndex = CGFloat(images.count / 2)
            let initialOffsetX = middleCardIndex * (self.cardWidth - overlap)
            self.scrollView.setContentOffset(CGPoint(x: initialOffsetX, y: 0), animated: false)
        }
        
        updateCardsScale()
    }

    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let overlap: CGFloat = 30
        let targetX = CGFloat(sender.currentPage) * (cardWidth - overlap)
        scrollView.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)
    }
    
    private func createCardView(with image: UIImage) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        cardView.addSubview(imageView)
        
        return cardView
    }
    
    private func updateCardsScale() {
        let centerX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        for cardView in cardViews {
            let cardCenterX = cardView.frame.midX
            let distance = abs(centerX - cardCenterX)
            let maxDistance = scrollView.bounds.width
            
            let scale = max(minimumScale, 1 - (distance / maxDistance) * 0.3)
            
            UIView.animate(withDuration: 0.3) {
                cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
                cardView.layer.zPosition = -abs(distance)
                
                if distance < 50 {
                    cardView.layer.shadowOpacity = 0.4
                    cardView.layer.shadowRadius = 12
                    cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
                        .translatedBy(x: 0, y: -10)
                } else {
                    cardView.layer.shadowOpacity = 0.2
                    cardView.layer.shadowRadius = 8
                }
            }
        }
        
        // Update page control
        let overlap: CGFloat = 30
        let currentPage = Int(round(scrollView.contentOffset.x / (cardWidth - overlap)))
        pageControl.currentPage = max(0, min(currentPage, pageControl.numberOfPages - 1))
    }
}

// MARK: - UIScrollViewDelegate
extension CarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCardsScale()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let overlap: CGFloat = 30
        let targetOffset = targetContentOffset.pointee.x
        let cardFullWidth = cardWidth - overlap
        let nearestCardIndex = round(targetOffset / cardFullWidth)
        
        targetContentOffset.pointee = CGPoint(
            x: nearestCardIndex * cardFullWidth,
            y: 0
        )
    }
    
}

