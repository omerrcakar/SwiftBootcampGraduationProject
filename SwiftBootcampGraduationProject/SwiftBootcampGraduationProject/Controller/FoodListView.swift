//
//  FoodListView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit

class FoodListView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var foodList: [Yemekler] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Yukardaki taımladığımız collection view'in aşağıdaki fonksiyonlarla bağı yok , burda bağladık
        collectionView.delegate = self
        collectionView.dataSource = self

        let y1 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y2 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y3 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y4 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y5 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        let y6 = Yemekler(yemek_id: "1", yemek_adi: "Pizza", yemek_resim_adi: "pizza", yemek_fiyat: "150")
        
        foodList.append(contentsOf: [y1,y2,y3,y4,y5,y6])
        
        
        
        // Screen size design
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 50)/3
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        
        collectionView.collectionViewLayout = design
        
    }
    
    
}

extension FoodListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodList[indexPath.row]
        
        // Hücremizi tanımladık
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        cell.foodImage.image = UIImage(named: food.yemek_resim_adi!)
        cell.foodName.text = food.yemek_adi
        cell.foodPrice.text = "\(food.yemek_fiyat!) ₺"
        
        
        // hucre etrafına border
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
}
