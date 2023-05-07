//
//  ViewController.swift
//  TheProjS
//
//  Created by Vladislav Zheleznyak on 26.04.2023.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var MainTableView: UITableView!
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MainTableView.dataSource = self
        loadTrendMovieData()
        MainTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        MainTableView.backgroundColor = .systemGray5

    }

//    override func viewWillAppear(_ animated: Bool) {
//        loadTrendMovieData()
//        MainTableView.backgroundColor = .orange
//    }
    
    private func loadTrendMovieData() {
        viewModel.fetchTrendMovieData { [weak self] in
            self?.MainTableView.dataSource = self
            self?.MainTableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = MainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //cell.textLabel?.text = "!!!!!!!!!"
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        //print(">>>>>>>>>> \(movie.title)\n\n\n\n")
        cell.setupCellWithValueOf(movie: movie)
        return cell
    }
}

