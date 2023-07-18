//
//  MyCollectionViewCell.swift
//  TestApp
//
//  Created by Shreya Chatterjee on 20/07/22.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet var imageView : UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)

        let images: [UIImage] = [
            UIImage(named: "download1"),
            UIImage(named: "download2"),
            UIImage(named: "download3"),
            UIImage(named: "download4"),
            UIImage(named: "download5"),
            UIImage(named: "download6"),
        ].compactMap({$0})
        imageView.image = images.randomElement()
        contentView.clipsToBounds = true
    }
    required init?(coder : NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    public func configure(with image: UIImage){
//        imageView.image = image
//    }
//
//    static func nib() -> UINib{
//        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
//    }

}
