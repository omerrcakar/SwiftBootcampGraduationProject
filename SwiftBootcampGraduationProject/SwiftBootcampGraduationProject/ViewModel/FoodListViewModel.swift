//
//  FoodListViewModel.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 17.03.2025.
//

import Foundation
import RxSwift

class FoodListViewModel{
    
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var yrepo = YemeklerDaoRepository()
    
    
    init(){
        yemeklerListesi = yrepo.yemeklerListesi
        yemekleriYukle()
    }
    
    func yemekleriYukle(){
        yrepo.uploadFood()
    }
    
}
