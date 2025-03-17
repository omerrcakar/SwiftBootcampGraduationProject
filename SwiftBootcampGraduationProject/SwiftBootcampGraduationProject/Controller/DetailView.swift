//
//  DetailView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit

class DetailView: UIViewController {

    
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCountLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    // Tıklanan yemek bilgisi buraya gelicek
    var yemek: Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let yemek = yemek {
            foodImageView.image = UIImage(named: yemek.yemek_resim_adi!)
            foodNameLabel.text = yemek.yemek_adi
            foodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
        }
    }
    
    
    
    @IBAction func stepperButton(_ sender: UIStepper) {
        stepperCountLabel.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func addCartButton(_ sender: UIButton) {
        if let gelenYemek = yemek {
            print("Sepete Eklendi : \(gelenYemek.yemek_adi!)")
        }
    }
    
    

}
