//
//  DetailViewModel.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 17.03.2025.
//

import Foundation

class DetailViewModel {
    
    var yrepo = YemeklerDaoRepository()
    
    func sepeteEkle(yemek_adi:String, yeme_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String){
        yrepo.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yeme_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
