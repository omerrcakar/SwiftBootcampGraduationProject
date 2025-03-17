//
//  YemeklerDaoRepository.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 17.03.2025.
//

import Foundation
import RxSwift
import Alamofire

class YemeklerDaoRepository{
    
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    // Tüm Yemekleri Getiriyoruz
    func uploadFood(){
    
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(YemeklerResponse.self, from: data)
                    if let liste = cevap.yemekler{
                        self.yemeklerListesi.onNext(liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    // Sepete Yemek Ekleme
    func addToCart(yemek_adi: String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String){
        let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat":yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Message: \(cevap.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    // Sepetteki Yemekleri Getirme
    func getCartItems(kullanici_adi:String){
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(SepetYemeklerResponse.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.sepetYemeklerListesi.onNext(liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    // Sepetten Yemek Silme
    func deleteFromCart(sepet_yemek_id:Int, kullanici_adi:String){
        let params: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Message: \(cevap.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
}
