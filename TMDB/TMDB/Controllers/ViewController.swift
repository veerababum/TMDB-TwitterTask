//
//  ViewController.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private var movies = [Movie]()
    var searchActive = true
    var activityView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        doInitialSetUp()
        addLoader()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit

        let image = UIImage(named: "logo.png")
        imageView.image = image

        navigationItem.titleView = imageView
    }

    func doInitialSetUp() {
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
    }

    func addLoader() {
        activityView = UIActivityIndicatorView.init(style: .large)
        activityView?.center = tableView.center
        activityView?.isHidden = true
        tableView.addSubview(activityView!)
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            activityView?.startAnimating()
            activityView?.isHidden = false
            MusicProvider.fetchMusicAlbums(searchText: searchText, completion: { albums in
                self.movies.removeAll()
                self.movies.append(contentsOf: albums)
                self.tableView.reloadData()
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true

            })
        }
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        let item = movies[indexPath.row]
        var str = ""
        if let genere = item.genreIds {
            for gener in genere {
                str = "\(str) \(gener), "
            }
            str = "\(str.dropLast().dropLast())"
        }
        
        let ratings = "\(item.voteAverage)"

        cell.bind(title: item.title, subTitle: item.overview, details: ratings, url: item.poster ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        vc?.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 
    }
}
