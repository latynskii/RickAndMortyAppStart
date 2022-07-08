//
//  RickMortyCell.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import UIKit
import Kingfisher

final class RickMortyCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseCell = "rick&MortyCell"
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "mock-image")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mock"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    //MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstrains()
    }
    

    private func makeUI() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        avatarImage.layer.cornerRadius = 8
        avatarImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.backgroundColor = .black
    }
    
    private func setupViews() {
        self.addSubview(avatarImage)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
    }
    
    private func setupConstrains() {
        avatarImage.snp.makeConstraints {
            
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(self.frame.width)
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImage.snp.bottom).offset(4)
            $0.leading.equalTo(self.snp.leading).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.bottom.equalTo(self.snp.bottom).offset(-4)
            $0.leading.equalTo(self.snp.leading).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-8)
        }
    }
    
    func configure(_ nameText: String, _ statusText: String, _ imageStr: String) {
        nameLabel.text = nameText
        statusLabel.text = statusText
        guard let url = URL(string: imageStr) else { return }
        avatarImage.kf.setImage(with: url)
    }
}
