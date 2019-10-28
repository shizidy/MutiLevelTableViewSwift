//
//  MutiLevelCell.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

class MutiLevelCell: UITableViewCell {
    
    /// 箭头
    var arrowImgView: UIImageView!
    var titleLabel: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        self.selectionStyle = .none
        self.arrowImgView = UIImageView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 25, y: 50 / 2 - 25 / 2, width: 25, height: 25))
        self.contentView.addSubview(self.arrowImgView)
        self.arrowImgView.image = UIImage.init(named: "right_arrow")
        
        self.titleLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 25 - 10, height: 50))
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.textColor = .gray
    }
    
    func fillCellWith(MutiLevelViewModel viewModel: MutiLevelViewModel, indexPath: NSIndexPath) {
        let model: MutiCityModel = viewModel.placesArray[indexPath.row] as! MutiCityModel
        self.titleLabel.text = model.name
        self.titleLabel.frame = CGRect.init(x: CGFloat(model.level * 10), y: 0, width: UIScreen.main.bounds.size.width - 25 - CGFloat(model.level * 10), height: 50)
        if model.isExpand == 1 {
            self.arrowImgView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        }
        if model.level == 3 {
            self.arrowImgView.isHidden = true
        } else {
            self.arrowImgView.isHidden = false
        }
    }
    
    func rotateArrowImgView(_ rotate: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.arrowImgView.transform = CGAffineTransform.init(rotationAngle: rotate)
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
