//
//  DetailHeaderView.swift
//  SpaceXFan
//
//  Created by Adem Kaya (employee ID: a84252243) on 2022/10/1.
//

import UIKit
import ImageSlideshow

class DetailHeaderView: UIView {
    private let slideshow: ImageSlideshow = {
        let slideshow = ImageSlideshow()

        slideshow.clipsToBounds = true
        slideshow.slideshowInterval = 5.0
        slideshow.contentScaleMode = .scaleAspectFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        return slideshow
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(slideshow)
    }

    func configure(with urls: [String]) {
        var imageSource = [KingfisherSource]()

        if !urls.isEmpty {
            for url in urls {
                imageSource.append(KingfisherSource(urlString: url)!)
                print("Urls \(url)")
            }
            slideshow.setImageInputs(imageSource)
        } else {
            slideshow.setImageInputs([
                ImageSource(image: UIImage(named: "Rocket")!)])
        }


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        slideshow.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
