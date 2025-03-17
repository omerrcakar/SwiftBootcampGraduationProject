
import Foundation

class SepetYemekler: Codable{
    var sepet_yemek_id:String?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:String?
    var yemek_siparis_adet:String?
    var kullanici_adi:String?
}

class SepetYemeklerResponse: Codable{
    var sepet_yemekler:[SepetYemekler]?
    var success:Int?
}
