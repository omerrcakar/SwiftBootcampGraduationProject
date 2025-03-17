//
//  CartView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit
import Kingfisher

class CartView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalOrderPrice: UILabel!
    
    var viewModel = CartViewModel()
    
    
    var foodList: [SepetYemekler] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // MVVM için RxSwift ile veri değişimi izlendiği yer
        _ = viewModel.sepetYemeklerListesi.subscribe(onNext: { liste in
            self.foodList = liste
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateTotalPrice()
            }
        })
    }
    
    func updateTotalPrice() {
        let total = foodList.reduce(0) { (result, food) -> Int in
            let price = Int(food.yemek_fiyat ?? "0") ?? 0
            let quantity = Int(food.yemek_siparis_adet ?? "0") ?? 0
            return result + (price * quantity)
        }
        totalOrderPrice.text = "\(total) ₺"
    }
    
    
    @IBAction func paymentClicked(_ sender: UIButton) {
        
    }
    

   

}

extension CartView: UITableViewDataSource, UITableViewDelegate, CellProtocol{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let food = foodList[indexPath.row]
        // Hücreye Bağlandık ve değerleri atadık
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartCell
        
        
        // Protokol işlemleri
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        
        // Cell içi atamalar
        // Kingfisher Yemek foto alma
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        
        cell.foodNameLabel.text = food.yemek_adi
        cell.foodPiecesCount.text = "\(food.yemek_siparis_adet!) pieces"
        cell.foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
        
        return cell
    }
    
    func trashButtonTapped(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        if let yemekId = Int(food.sepet_yemek_id!){
            viewModel.sepettenYemekSil(sepet_yemek_id: yemekId, kullanici_adi: "cakaromer")
        }
        viewModel.sepetYemekleriYukle()
    }
}
