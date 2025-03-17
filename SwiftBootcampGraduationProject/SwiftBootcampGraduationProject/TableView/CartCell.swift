//
//  CartCell.swift
//  SwiftBootcampGraduationProject
//
//  Created by ÖMER  on 17.03.2025.
//

import UIKit

protocol CellProtocol{
    func trashButtonTapped(indexPath:IndexPath)
}

class CartCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPiecesCount: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    var cellProtocol:CellProtocol?
    var indexPath:IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func foodTrashButton(_ sender: UIButton) {
        cellProtocol?.trashButtonTapped(indexPath: indexPath!)
        
    }
    

}
