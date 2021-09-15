//
//  ArticleCell.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay: Article!
    
    func displayArticle(_ article: Article) {
        titleLabel.text = ""
        articleImageView.image = nil
        
        titleLabel.alpha = 0
        articleImageView.alpha = 0
        
        articleToDisplay = article
        titleLabel.text = articleToDisplay.title
        
        UIView.animate(withDuration: 1, delay: 0.2, options: []) {
            self.titleLabel.alpha = 1
        }
        
        guard let urlString = articleToDisplay.urlToImage else {
            return
        }
        
        if let imageData = CacheManager.retrievedData(urlString) {
            articleImageView.image = UIImage(data: imageData)
        }
        
        UIView.animate(withDuration: 1, delay: 0.2, options: []) {
            self.articleImageView.alpha = 1
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("Fail to create url")
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                CacheManager.saveData(urlString, data)
                
                if self.articleToDisplay.urlToImage == urlString {
                    DispatchQueue.main.async {
                        self.articleImageView.image = image
                        
                        UIView.animate(withDuration: 1, delay: 0.2, options: []) {
                            self.articleImageView.alpha = 1
                        }
                    }
                }
            }
        }.resume()
    }
    
    override func layoutSubviews() {
        let margins = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = UIColor.systemGray6.cgColor
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
