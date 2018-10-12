//
//  ArticleCell.swift
//  News
//
//  Created by Vitaliy Kurbatov on 13/02/2018.
//  Copyright © 2018 Vitaliy Kurbatov. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayArticle(_ article:Article) {
        
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        articleImageView.image = nil
        articleToDisplay = article
        headlineLabel.text = articleToDisplay!.title!
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.headlineLabel.alpha = 1
        }, completion: nil)
        
        let urlString = articleToDisplay!.urlToImage
        
        guard urlString != nil else {
            return
        }
        
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            articleImageView.image = UIImage(data: cachedData!)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImageView.alpha = 1
            }, completion: nil)
    
            return
        }
        
        let url = URL(string: urlString!)
        
        guard url != nil else {
            print("can't download image")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                
                CacheManager.saveImageData(urlString!, data!)
                
                if self.articleToDisplay!.urlToImage == urlString! {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImageView.alpha = 1
                        }, completion: nil)
                    }
                } // End if
            } // End if
        } // End data task
        
        dataTask.resume()
    }
}
