//
//  DescriptionViewController.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit
import CoreData

class DescriptionViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var openType : OpenTypes?
      var selectedHotel:Int?
      let viewModel = DescriptionVM()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setupUi()
          startApp()

      }
      
      func setupUi() {
          UIApplication.shared.statusBarStyle = .lightContent
          if openType == .hotel{
              titleLabel.text = Helper.hotelList![selectedHotel!].name.content

          descriptionLabel.text = Helper.hotelList![selectedHotel!].hotelDescription.content
          backImageView.sd_setImage(with: URL(string: NetworkUtils.mediumImageUrl+(Helper.hotelList?[selectedHotel!].images?[5].path ?? "")))
          }else{
              titleLabel.text = viewModel.flightTitle.value
              descriptionLabel.text = viewModel.flightDescription.value
              backImageView.image = UIImage(named: "flightBack")
              print(viewModel.flightDescription.value)
            
          }
          addButton.layer.cornerRadius = 8
          backButton.layer.cornerRadius = 7
          navigationController?.navigationBar.isHidden = true
          backImageView.layer.cornerRadius = 32
          backImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
      }
      
      func startApp(){
          
          viewModel.selectedHotelIndex = selectedHotel
          viewModel.openType = openType
          viewModel.buttonText.bind(observer: { text in
              self.addButton.setTitle(text, for: .normal)
              
          })
          if openType != .hotel{

          viewModel.flightDescription.bind(observer: { text in
              self.descriptionLabel.text = self.viewModel.flightDescription.value
              
          })
          viewModel.flightTitle.bind(observer: { text in
              self.titleLabel.text = self.viewModel.flightTitle.value
              
          })
              viewModel.imageUrl.bind(observer: { text in
                  if text != ""{
                      self.backImageView.sd_setImage(with: URL(string: NetworkUtils.mediumImageUrl+(text!)))
                  }
           
              })
          }
          viewModel.setAssetStatus()
        
      }
      
      @IBAction func addButtonTapped(_ sender: UIButton) {
          viewModel.tappedAddFavorite()
      }
      
      @IBAction func backButtonTapped(_ sender: Any) {
          navigationController?.popViewController(animated: true)
      }
  }
