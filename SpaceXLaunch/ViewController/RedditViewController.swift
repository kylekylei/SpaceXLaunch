//
//  RedditViewController.swift
//  SpaceXLaunch
//
//  Created by Kyle Lei on 2021/12/26.
//

import UIKit
import WebKit



class RedditViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!{
        didSet {
            spinner.style = .large
        }
    }
    
    
    var urlStr: String
    init?(coder: NSCoder, urlStr: String){
        self.urlStr = urlStr
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        if let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateUI()
        spin(spinner: spinner)
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
