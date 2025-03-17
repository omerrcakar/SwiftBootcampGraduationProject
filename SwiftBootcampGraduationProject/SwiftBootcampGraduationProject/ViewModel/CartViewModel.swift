//
//  CartViewModel.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 17.03.2025.
//

import Foundation
import RxSwift

class CartViewModel {
    var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    var yrepo = YemeklerDaoRepository()
    
    init(){
        sepetYemeklerListesi = yrepo.sepetYemeklerListesi
        sepetYemekleriYukle()
    }
    
    
    func sepetYemekleriYukle(){
        yrepo.getCartItems(kullanici_adi: "cakaromer")
    }
    
    func sepettenYemekSil(sepet_yemek_id: Int, kullanici_adi: String){
        yrepo.deleteFromCart(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}
