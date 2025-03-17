//
//  FoodCell.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit

protocol HucreProtocol{
    func addToCartButtonClicked(indexPath:IndexPath)
}

class FoodCell: UICollectionViewCell {
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    // Sepete Ekle butonu hücre içinde çalışıyor ama hangi yemek olduğunu buradan anlamıyoruz
    // Yemek nesnesine erişmem lazım anacak buradan erişemiyoruz
    // Ancak biz bu butonu FoodListView içinde kullanıp yemek nesnelerine erişmemiz lazım
    // butonu tıklayınca burada çalışıyor ancak biz FoodListView içinde çalışmamız lazım
    // Tıklayınca FoodListView içinde işlem yapıcaz
    // Tetikleyen burası , kullanılacak yer FoodListView
    @IBAction func addFoodButton(_ sender: UIButton) {
        
        hucreProtocol?.addToCartButtonClicked(indexPath: indexPath!)
    }
    
}
