//
//  FoodListView.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 16.03.2025.
//

import UIKit
import Kingfisher

class FoodListView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var foodList: [Yemekler] = []
    var viewModel = FoodListViewModel()
    
    // Yatay Kaydırma
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    
    let foodCategories = [
            ("Pizza", "🍕"),
            ("Burger", "🍔"),
            ("Sushi", "🍣"),
            ("Kebap", "🥙"),
            ("Tatlı", "🍰"),
            ("İçecek", "🥤")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupScrollView()
        setupCategories()
        
        // Yukardaki taımladığımız collection view'in aşağıdaki fonksiyonlarla bağı yok , burda bağladık
        collectionView.delegate = self
        collectionView.dataSource = self

        
        // MVVM için RxSwift ile veri değişimi izlendiği yer
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.foodList = liste
            
            // Arayğze verileri yüklerken asenkron yani performanslı çalışmamızı sağlar
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        })
        
        
        
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

extension FoodListView: UICollectionViewDelegate, UICollectionViewDataSource, HucreProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodList[indexPath.row]
        
        // Hücremizi tanımladık
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        // Kingfisher Yemek foto alma
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }
        }
        
        cell.foodName.text = food.yemek_adi
        cell.foodPrice.text = "\(food.yemek_fiyat!) ₺"
        
        
        // Protocol işlemleri
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        
        // hucre etrafına border
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Seçilen yemeği , detay sayfasında görüntüleme
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let veri = sender as? Yemekler {
                let destination = segue.destination as! DetailView
                destination.yemek = veri
            }
        }
    }
    
    func addToCartButtonClicked(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        print("Sepete Eklendi: \(food.yemek_adi!)")
    }
}


extension FoodListView{
    func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsHorizontalScrollIndicator = false
            view.addSubview(scrollView)
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.heightAnchor.constraint(equalToConstant: 120)
            ])
            
            stackView.axis = .horizontal
            stackView.spacing = 15
            stackView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        }
    
    func setupCategories() {
            for category in foodCategories {
                let categoryView = createCategoryView(title: category.0, emoji: category.1)
                stackView.addArrangedSubview(categoryView)
            }
        }
    
    func createCategoryView(title: String, emoji: String) -> UIView {
            let view = UIView()
            view.backgroundColor = UIColor.systemGray6
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 70).isActive = true
            view.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            let imageView = UILabel()
            imageView.text = emoji
            imageView.font = UIFont.systemFont(ofSize: 30)
            imageView.textAlignment = .center
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .center
            
            let stack = UIStackView(arrangedSubviews: [imageView, label])
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(stack)
            
            NSLayoutConstraint.activate([
                stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            return view
        }
}
