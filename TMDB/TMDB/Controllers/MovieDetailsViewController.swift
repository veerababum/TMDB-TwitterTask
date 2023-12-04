//
//  MovieDetailsViewController.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movie: Movie?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailsViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        rotated()

    }
    
    @objc func rotated() {
        scrolView.layoutIfNeeded()
        stackView.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            let contentSize = self.stackView.frame.origin.y+self.stackView.frame.size.height
            self.scrolView.contentSize = CGSize(width: self.view.frame.size.width, height: contentSize)
            self.contentView.translatesAutoresizingMaskIntoConstraints = true
            self.contentView.frame = CGRect(x: self.contentView.frame.origin.x,
                                            y: self.contentView.frame.origin.y,
                                            width: self.contentView.frame.size.width,
                                       height: contentSize)

        }
    }
    func bindData() {
        self.title = movie?.title
        lblTitle.text = movie?.title
        
        var str = ""
        if let genere = movie?.genreIds {
            for gener in genere {
                str = "\(str) \(gener), "
            }
            str = "\(str.dropLast().dropLast())"
        }
        var releaseDate = ""
        if let reDate = movie?.releaseDate{
            releaseDate = reDate
        }
        
        let ratings = "\(movie?.voteAverage ?? 5.0)"
        
        let subTitle = "\(releaseDate) | \(str)"
        
        lblSubTitle.text = subTitle
        lblRatings.text = ratings
        lblDescription.text = movie?.overview
        let imgURLName = ApiConstants.originalImageUrlString+(movie?.poster ?? "")

        imgView.imageWith(urlString: imgURLName, placeholder: "")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
