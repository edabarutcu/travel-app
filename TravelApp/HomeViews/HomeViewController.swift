//
//  ViewController.swift
//  TravelApp
//
//  Created by eda on 1.10.2022.
//


import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController , UITabBarControllerDelegate{
    
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelsView: UIView!
    var viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startApp()
        setupUi()
    }
    
    func startApp(){
        viewModel.startApp()
        viewModel.callServices()
    }
    
    func setupUi(){
        hotelsView.layer.cornerRadius = 8
        flightView.layer.cornerRadius = 8
        
        let gestureFlight = UITapGestureRecognizer(target: self, action: #selector(clickFlights))
        flightView.isUserInteractionEnabled = true
        flightView.addGestureRecognizer(gestureFlight)
        
        let gestureHotel = UITapGestureRecognizer(target: self, action: #selector(clickHotels))
        hotelsView.isUserInteractionEnabled = true
        hotelsView.addGestureRecognizer(gestureHotel)
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.bottomCollectionView.register(nib, forCellWithReuseIdentifier:  "CollectionViewCell")
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
    }
    
    
    @objc func clickFlights (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destinationVC.openType = .flight
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func clickHotels (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destinationVC.openType = .hotel
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: 250, height: collectionView.frame.height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dialog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bottomCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.titleLabel.text = viewModel.title[indexPath.row]
        cell.descriptionLabel.text = viewModel.dialog[indexPath.row]
        cell.imageView.image = viewModel.photos[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destinationVC.openType = .hotel
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}






