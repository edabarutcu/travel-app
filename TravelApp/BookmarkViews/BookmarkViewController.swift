//
//  BookmarkViewController.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    let viewModel = BookMarksVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        startApp()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        startApp()
    }
    
    func setupUi(){
        let nib = UINib(nibName: "bookmarkTableViewCell", bundle: nil)
        self.bookmarkTableView.register(nib, forCellReuseIdentifier:  "bookmarkTableViewCell")
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
    }
    
    func startApp(){
        viewModel.trips.bind(observer: { text in
            self.bookmarkTableView.reloadData()
            
        })
        viewModel.setAssetStatus()
    }
    
}

extension BookmarkViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trips.value?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkTableViewCell", for: indexPath) as! bookmarkTableViewCell
        tableView.separatorStyle = .none
        
        cell.descriptionlabel.text = viewModel.trips.value?[indexPath.row].hotelDescription
        cell.backImageView.sd_setImage(with: URL(string: NetworkUtils.mediumImageUrl+(viewModel.trips.value?[indexPath.row].images ?? "")))
        cell.titleLabel.text = viewModel.trips.value?[indexPath.row].name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.findSelectedNumberOfItem(index: indexPath.row)
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        destinationVC.selectedHotel = indexPath.row
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

