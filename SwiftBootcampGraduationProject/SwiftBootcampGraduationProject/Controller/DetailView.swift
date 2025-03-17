//
//  DetailView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit
import Kingfisher

class DetailView: UIViewController {

    
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCountLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    // Tıklanan yemek bilgisi buraya gelicek
    var yemek: Yemekler?
    var siparisAdet: Int = 1
    
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let yemek = yemek {
            
            // Kingfisher Yemek foto alma
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.foodImageView.kf.setImage(with: url)
                }
            }
            
            foodNameLabel.text = yemek.yemek_adi
            foodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
        }
    }
    
    
    
    @IBAction func stepperButton(_ sender: UIStepper) {
        siparisAdet = Int(sender.value)
        stepperCountLabel.text = "\(siparisAdet)"
    }
    
    
    @IBAction func addCartButton(_ sender: UIButton) {
        if let gelenYemek = yemek {
            if let gelenYemekFiyat = Int(gelenYemek.yemek_fiyat!){
                viewModel.sepeteEkle(yemek_adi: gelenYemek.yemek_adi!, yeme_resim_adi: gelenYemek.yemek_resim_adi!, yemek_fiyat: gelenYemekFiyat, yemek_siparis_adet: siparisAdet, kullanici_adi: "cakaromer")
            }
            
        }
        
    }
    
    

}
