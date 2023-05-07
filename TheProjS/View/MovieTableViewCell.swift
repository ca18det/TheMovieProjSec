//
//  MovieTableViewCell.swift
//  TheProjS
//
//  Created by Vladislav Zheleznyak on 27.04.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var logoPicImage: UIImageView!
    
    @IBOutlet var movieLabel: UILabel!
    
    @IBOutlet var descriptionMovieLabel: UILabel!
    
    // Setup movies Value
    func setupCellWithValueOf(movie: Results) {
        updateUI(logoImage: movie.poster_path, movieLabl: movie.title, descripLabl: movie.overview)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private var urlString = ""
    
    // Mark: - Update the UI View
    private func updateUI(logoImage: String?, movieLabl: String?, descripLabl: String?) {
        
        guard let logoString = logoImage else { return }
        //urlString = "https://image.tmdb.org/t/p/w300" + logoString
        urlString = "https://image.tmdb.org/t/p/original/" + logoString
        self.movieLabel.text = "1111111"
        self.descriptionMovieLabel.text = descripLabl
        
        guard let logoImageURL = URL(string: urlString) else {
            self.logoPicImage.image = UIImage(named: "image no")
            return
        }
        
        // Before we download the image we clear out the old one
        //self.logoPicImage.image = nil
        
        getImageDataFrom(url: logoImageURL)
    }

        //Mark: - Get image data
        
        private func getImageDataFrom(url: URL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                //Handle error
                if let error = error {
                    print("Get image ERROR: \(error.localizedDescription)")
                }
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                DispatchQueue.main.async {
                    if let img = UIImage(data: data) {
                        self.logoPicImage.image = img
                    }
                }
            }.resume()
        }
        
    // Mark: - Convert date
    func convertDateFormater(date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newData = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                fixDate = dateFormatter.string(from: newData)
            }
        }
        return fixDate
    }
}
