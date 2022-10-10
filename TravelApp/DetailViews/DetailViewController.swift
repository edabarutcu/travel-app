//
//  DetailViewController.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    var openType:OpenTypes?
    let viewModel = DetailViewVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        startApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.startApp()
    }
    
    @objc func backViewTapped (){
        navigationController?.popViewController(animated: true)
    }
    
    func setupUi() {
        navigationController?.navigationBar.isHidden = true
        if openType == .hotel{
            backTitle.text = "Hotels"
        }else{
            backTitle.text = "Flights"
            
        }
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewTapped)))
        detailTableView.delegate = self
        detailTableView.dataSource = self
        let backButton = UIBarButtonItem()
        
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let nib = UINib(nibName: "bookmarkTableViewCell", bundle: nil)
        self.detailTableView.register(nib, forCellReuseIdentifier:  "bookmarkTableViewCell")
    }
    func startApp (){
        viewModel.startApp()
        viewModel.hotelsArray.bind(observer: { hotels in
            
            self.detailTableView.reloadData()
            
        })
        viewModel.flightArray.bind(observer: { flights in
            self.detailTableView.reloadData()
            
        })
    }
}

extension DetailViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openType == .hotel{
           // print(viewModel.hotelsArray.value?.count)
            return viewModel.hotelsArray.value?.count ?? 0
        }else{
            if viewModel.flightArray.value?.count != 0{
            return 100
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkTableViewCell", for: indexPath) as! bookmarkTableViewCell
        tableView.separatorStyle = .none
        
        if openType == .hotel{
            cell.descriptionlabel.text = viewModel.hotelsArray.value?[indexPath.row].hotelDescription.content
            cell.backImageView.sd_setImage(with: URL(string: NetworkUtils.mediumImageUrl+(viewModel.hotelsArray.value?[indexPath.row].images?[5].path ?? "")))
            cell.titleLabel.text = viewModel.hotelsArray.value?[indexPath.row].name.content
        }else{
            cell.descriptionlabel.text = "\(viewModel.flightArray.value?[indexPath.row].departure_date ?? "") - \(viewModel.flightArray.value?[indexPath.row].arrival_date ?? "")"
            cell.backImageView.image = UIImage(named: "flightBack")
            cell.titleLabel.text = viewModel.flightArray.value?[indexPath.row].arrival
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        destinationVC.selectedHotel = indexPath.row
      //  print(openType?.hashValue)
        destinationVC.openType = openType
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}
