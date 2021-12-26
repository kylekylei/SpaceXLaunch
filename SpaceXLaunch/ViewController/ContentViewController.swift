//
//  ContentViewController.swift
//  SpaceXLaunch
//
//  Created by Kyle Lei on 2021/12/25.
//

import UIKit
import youtube_ios_player_helper


class ContentViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var petalImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.style = .large
        }
    }
    
    var searchResponse: SearchResponse?
    let playerView = YTPlayerView()
    var detail: String?
    var redditStr: String?
    var isLoad = false
    
    func fetchItems() {
        let urlStr = "https://api.spacexdata.com/v4/launches/latest"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        self.searchResponse = try decoder.decode(SearchResponse.self, from: data)

                        DispatchQueue.main.async {
                            self.nameLabel.text = self.searchResponse?.name
                            self.detail = self.searchResponse?.details
                            self.redditStr = self.searchResponse?.links.reddit.launch
                            
                            self.fetchImage(url: self.searchResponse!.links.patch.small)
                            
                            if let releaseDate = self.searchResponse?.date_unix {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let releaseDateStr = dateFormatter.string(from: releaseDate)
                                self.releaseDateLabel.text = releaseDateStr
                            }
                            
                            if let videoID = self.searchResponse?.links.youtube_id {
                                self.playerView.load(withVideoId: videoID)
                                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                    self.playerView.playVideo()
                                }
                            }
                            
                            
                        }

                    }catch {
                        print(error)
                    }
                }else {
                    print("error")
                }
            }.resume()
        }
        
    }
    func fetchImage(url: URL){
        URLSession.shared.dataTask(with: url ) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.petalImage.image = UIImage(data: data)
                }
            }
        }.resume()
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchItems()
        playerView.frame = CGRect(x: 0, y: 50, width: videoSize.width, height: videoSize.heigh)
        view.addSubview(playerView)
        spin(spinner: spinner)
    }
    
    
    @IBAction func showDescription(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: detail, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }

    
    @IBSegueAction func showWeb(_ coder: NSCoder) -> RedditViewController? {
        RedditViewController(coder: coder, urlStr: redditStr!)
    }
    

    
}
