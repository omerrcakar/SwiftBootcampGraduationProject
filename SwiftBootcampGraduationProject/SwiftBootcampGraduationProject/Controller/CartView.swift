//
//  CartView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit

class CartView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var totalOrderPrice: UILabel!
    
    
    
    var foodList: [Yemekler] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let y1 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y2 = Yemekler(yemek_id: "2", yemek_adi: "Makarna", yemek_resim_adi: "pizza", yemek_fiyat: "250")
        let y3 = Yemekler(yemek_id: "3", yemek_adi: "Pide", yemek_resim_adi: "pizza", yemek_fiyat: "350")
        let y4 = Yemekler(yemek_id: "4", yemek_adi: "Lahmacun", yemek_resim_adi: "pizza", yemek_fiyat: "100")
        let y5 = Yemekler(yemek_id: "5", yemek_adi: "Döner", yemek_resim_adi: "pizza", yemek_fiyat: "270")
        let y6 = Yemekler(yemek_id: "6", yemek_adi: "Kumpir", yemek_resim_adi: "pizza", yemek_fiyat: "130")
        
        foodList.append(contentsOf: [y1,y2,y3,y4,y5,y6])
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
        cell.foodImageView.image = UIImage(named: food.yemek_resim_adi!)
        cell.foodNameLabel.text = food.yemek_adi
        cell.foodPiecesCount.text = "2 pieces"
        cell.foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
        
        return cell
    }
    
    func trashButtonTapped(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        print("Silindi: \(food.yemek_adi!)")
    }
}
