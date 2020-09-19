//
//  MoviesCell.swift
//  Media Finder X
//
//  Created by yasser on 8/22/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import SDWebImage
class MoviesCell: UITableViewCell {

    @IBOutlet weak var movieLabelName: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabelReleaseDate: UILabel!
    @IBOutlet weak var movieLongDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(media: Media){
        let mediaType = media.getType()
        if mediaType == MediaTypes.tvShow{
            self.movieLabelName.text = media.artistName ?? ""
        }else{
            self.movieLabelName.text = media.trackName ?? ""
        }
        if mediaType == MediaTypes.music {
            self.movieLongDescriptionLabel.text = media.artistName ?? ""
        }else{
            self.movieLongDescriptionLabel.text = media.longDescription ?? ""
        }
        if let artImageUrl = URL(string: media.artworkUrl100) {
            movieImageView.sd_setImage(with: artImageUrl ,placeholderImage: UIImage(named: "placeholder") ,options: .highPriority, progress: nil , completed: nil)
        }
        //movieImageView.sd_setImage(with: URL(string: media.artworkUrl100),placeholderImage: UIImage(named: "placeholder"))
        
    }
    
    func shake(view: UIImageView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 1
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            view.layer.borderWidth = 0
        }
        
        propertyAnimator.startAnimation()
    }
    
    
    
    @IBAction func imageAnimationBtn(_ sender: UIButton) {
        shake(view: movieImageView)
        
    }
}
