//
//  SearchViewController.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var flightSegment: UIImageView!
    @IBOutlet weak var hotelSegment: UIImageView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    var openType:OpenTypes = .hotel
    let viewModel = SearchVM ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startApp()
        setupUi()
        clickFlights()
        clickHotel()
    }
    
    func setupUi(){
        let nib = UINib(nibName: "BookmarkTableViewCell", bundle: nil)
        self.searchTableView.register(nib, forCellReuseIdentifier:  "BookmarkTableViewCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
        let gestureHotel = UITapGestureRecognizer(target: self, action: #selector(clickHotel))
        hotelSegment.isUserInteractionEnabled = true
        hotelSegment.addGestureRecognizer(gestureHotel)
        let gestureFlight = UITapGestureRecognizer(target: self, action: #selector(clickFlights))
        flightSegment.isUserInteractionEnabled = true
        flightSegment.addGestureRecognizer(gestureFlight)
    }
    // TODO change images
    @objc func clickHotel (){
        openType = .hotel
        hotelSegment.image = UIImage(named: "hotel segment selected")
        flightSegment.image = UIImage(named: "flights2")
    }
    
    @objc func clickFlights (){
        openType = .flight
        hotelSegment.image = UIImage(named: "hotel segment")
        flightSegment.image = UIImage(named: "flights3")
    }
    
    func startApp(){
        
        viewModel.filteredFlights.bind(observer: { array in
            self.view.activityStopAnimating()
            self.searchTableView.reloadData()
            if array?.count == 0{
                self.noDataView.isHidden = false
                self.searchTableView.isHidden = true
            }else{
                self.noDataView.isHidden = true
                self.searchTableView.isHidden = false
            }
            
        })
        
        viewModel.filteredHotels.bind(observer: { array in
            self.view.activityStopAnimating()
            self.searchTableView.reloadData()
            if array?.count == 0{
                self.noDataView.isHidden = false
                self.searchTableView.isHidden = true
            }else{
                self.noDataView.isHidden = true
                self.searchTableView.isHidden = false
            }
        })
    }
    
    @objc func searchTextFieldChanged(_ textField: UITextField) {
        if textField.text!.count > 2 {
            viewModel.filteredFlights.value = []
            viewModel.filteredHotels.value = []
            view.activityStartAnimating()
            if openType == .flight{
                viewModel.searchList(text: textField.text ?? "")
            }else{
                viewModel.getHotelList(text: textField.text ?? "")
            }
            if viewModel.filteredHotels.value?.count ?? 0 < 1 && viewModel.filteredFlights.value?.count ?? 0 < 1{
                DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                    self.view.activityStopAnimating()
                    self.noDataView.isHidden = false
                    self.searchTableView.isHidden = true
                }
            }
        }else{
            viewModel.filteredFlights.value = []
            viewModel.filteredHotels.value = []
        }
    }
}

extension SearchViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openType == .flight{
            return viewModel.filteredFlights.value?.count ?? 0
        }else{
            return viewModel.filteredHotels.value?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as! BookmarkTableViewCell
        tableView.separatorStyle = .none
        if openType == .flight{
            cell.titleLabel.text = viewModel.filteredFlights.value?[indexPath.row].arrival
            cell.descriptionlabel.text = viewModel.filteredFlights.value?[indexPath.row].arrival_date
            cell.backImageView.image = UIImage(named: "flightBack")
        }else{
            cell.titleLabel.text = viewModel.filteredHotels.value?[indexPath.row].name.content
            cell.descriptionlabel.text = viewModel.filteredHotels.value?[indexPath.row].hotelDescription.content
            cell.backImageView.sd_setImage(with: URL(string: NetworkUtils.mediumImageUrl+(viewModel.filteredHotels.value?[indexPath.row].images?[5].path ?? "")))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        if openType == .flight{
            viewModel.findIndexNumber(index: indexPath.row)
        }else{
            viewModel.findHotelIndexNumber(index: indexPath.row)
        }
        destinationVC.openType = openType
        destinationVC.selectedHotel = viewModel.selectedItemNumber
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

