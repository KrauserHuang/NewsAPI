//
//  ViewController.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import UIKit

struct PropertyKeys {
    static let reuseIdentifier = "ArticleCell"
    static let withIdentifier = "DetailViewController"
}

class ViewController: UIViewController {
    
    var model = ArticleModel()
    var articles = [Article]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model.delegate = self
        
        model.fetchArticles()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        model.fetchArticles()
//    }
    @objc func pullToRefresh() {
        model.fetchArticles()
    }
}
//MARK: - ArticleModelProtocol
extension ViewController: ArticleModelProtocol {
    func articlesRetrieved(_ articles: [Article]) {
        print("Articles returned from model!")
        
        self.articles = articles
        
        // table view 結束 refreshing
        tableView.refreshControl?.endRefreshing()
        
        // Refresh table view
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.reuseIdentifier, for: indexPath) as? ArticleCell else {
            fatalError("Fail to dequeue ArticleCell")
        }
        
        let article = articles[indexPath.row]
        cell.displayArticle(article)
        
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: PropertyKeys.withIdentifier) as! DetailViewController
        
        let article = articles[indexPath.row]
        detailVC.articleURL = article.url
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
