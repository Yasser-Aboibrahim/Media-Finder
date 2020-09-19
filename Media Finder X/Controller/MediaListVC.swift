//
//  MediaListVC.swift
//  Media Finder X
//
//  Created by yasser on 8/22/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import AVKit
import EmptyDataSet_Swift
class MediaListVC: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK:- Outlets
    var mediaArr = [Media]()
    var currentMediaArr = [Media]()
    var mediaType: MediaTypes = .music
    var searchBarText: String = ""
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultManager.shared().isLoggedIn = true
        
        setNavigationBar()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        setMediaDataBase()
        setTableView()
        self.tableView.reloadData()
    }
    
    // MARK:- Public Methods
    @objc func tapBtn(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.profileVC ) as! ProfileVC
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func setNavigationBar(){
        let addBtn = UIBarButtonItem(title: "Profile >", style: .plain, target: self, action: #selector(tapBtn))
        self.navigationItem.rightBarButtonItem = addBtn
        self.navigationItem.hidesBackButton = true
    }
    
    private func setTableView(){
        tableView.register(UINib(nibName: Cells.movieCell, bundle: nil), forCellReuseIdentifier: Cells.movieCell)
        SetDelegate()
        self.tableView.backgroundColor = .gray
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setMediaDataBase(){
        MediaManager.Shared().setupConnection()
        MediaManager.Shared().createTable()
        MediaManager.Shared().getMediaDatabase{ mediaArray in
            if  !mediaArray!.isEmpty{
                self.mediaArr = mediaArray!
                self.currentMediaArr = self.mediaArr
                SegmentedInitializationVlaue(mediaFirstElement: self.currentMediaArr[0])
            }else{
                self.mediaArr = []
                self.currentMediaArr = self.mediaArr
            }
        }
    }
    
    
    private func SegmentedInitializationVlaue(mediaFirstElement: Media){
        switch mediaFirstElement.kind {
        case mediaKindKeys.song :
            segmentedControl.selectedSegmentIndex = 0
        case mediaKindKeys.movie:
            segmentedControl.selectedSegmentIndex = 1
        case mediaKindKeys.tvShow:
            segmentedControl.selectedSegmentIndex = 2
        default:
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    
    
    private func SetDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func tableViewReloadData(){
        if searchBarText != ""{
        MediaManager.Shared().deleteMedia()
        getData()
        }else{
            MediaManager.Shared().deleteMedia()
            currentMediaArr = []
            mediaArr = []
            self.tableView.reloadData()
        }
    }
    
    private func getData(){
        APIManager.loadMovies(mediaType: mediaType.rawValue,criteria: searchBarText){ (error, media) in
            if let error = error{
                print(error.localizedDescription)
            }else if let media = media{
                if media.isEmpty{
//                    self.showAlertWithCancel(alertTitle: "No Results", message: "Sorry, we didn't find any results matching this search", actionTitle: "Cancel")
                    self.tableView.emptyDataSetView { view in
                        view.image(UIImage(named: "notfound"))
                        
                    }
                }else{
                    self.mediaArr = media
                    self.currentMediaArr = self.mediaArr
                }
                
            }
            MediaManager.Shared().insertMedia(mediaArr: self.currentMediaArr)
            self.tableView.reloadData()
        }
        
    }
    
    

        // MARK:- Actions
        @IBAction func segSwitchAction(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            mediaType =  MediaTypes.music
        tableViewReloadData()
        case 1:
            mediaType = MediaTypes.movie
        tableViewReloadData()
        case 2:
            mediaType = MediaTypes.tvShow
        tableViewReloadData()
        default:
            tableViewReloadData()
            return mediaType = MediaTypes.music
        }
   }
    


}

// MARK:- tableveiw extension
extension MediaListVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("mediaArr        \(mediaArr.count) line 143 -> MovieListVC")
        print("currentMediaArr \(currentMediaArr.count) line 144 -> MovieListVC")
        return self.currentMediaArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell, for: indexPath) as? MoviesCell else{
            return UITableViewCell()
        }
        cell.configure(media: self.currentMediaArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaKind = currentMediaArr[indexPath.row].kind
        if mediaKind == mediaKindKeys.song {
            playAudioFromURL(PreviewUrl: currentMediaArr[indexPath.row].previewUrl)
        }else{
            playVideoFromURL(PreviewUrl: currentMediaArr[indexPath.row].previewUrl)
            
        }
    }
    
    private func playAudioFromURL(PreviewUrl: String) {
        guard let url = URL(string: PreviewUrl) else {
            print("error to get the mp3 file")
            return
        }
        
        let audioPlayer = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = audioPlayer
         present(controller, animated: true) {
        audioPlayer.play()
        }
    }
    
    private func playVideoFromURL(PreviewUrl: String) {
        guard let url = URL(string: PreviewUrl) else {
            return
        }
        // Create an AVPlayer, passing it import AVKitthe HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
    }
    
    
    
}

// MARK:- searchbar extension
extension MediaListVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchBar.text!
        guard searchText != "" else {
            currentMediaArr = mediaArr
            self.tableView.reloadData()
            return
        }
        currentMediaArr = mediaArr.filter({ media -> Bool in
            searchBarText = searchText
            return (media.artistName?.contains(searchText))!
            
        })
        tableViewReloadData()
    }
    

}

extension MediaListVC: EmptyDataSetSource, EmptyDataSetDelegate{
    
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }
    
}
