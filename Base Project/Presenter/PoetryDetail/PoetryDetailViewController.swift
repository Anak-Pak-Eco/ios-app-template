//
//  PoetryDetailViewController.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 01/10/23.
//

import Foundation
import UIKit

class PoetryDetailViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let author: String
    let poetryTitle: String
    
    init(author: String, title: String) {
        self.author = author
        self.poetryTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(author: "", title: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        mainTableView.register(
            UINib(nibName: "AuthorCell", bundle: nil), 
            forCellReuseIdentifier: "AuthorCell"
        )
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 80
        mainTableView.separatorStyle = .none
        mainTableView.estimatedRowHeight = UITableView.automaticDimension
        mainTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension PoetryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let authorCell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell", for: indexPath) as! AuthorCell
        return authorCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
