import Foundation
import UIKit

class CustomCell:UITableViewCell {
    
    var phoneImage = UIImageView()
    private let phoneTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with foto: CatsFoto, andWith facts: Fact) {
        phoneTitle.text = facts.text
        phoneImage.loadImageFromURL(urlString: foto.url, placeholder: UIImage(systemName: "star.fill"))
    }
    
    private func setUpLayout() {
        contentView.addSubview(phoneTitle)
        contentView.addSubview(phoneImage)
        
        phoneTitle.translatesAutoresizingMaskIntoConstraints = false
        phoneImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            phoneImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            phoneImage.heightAnchor.constraint(equalToConstant: 60),
            phoneImage.widthAnchor.constraint(equalToConstant: 80),
            
            phoneTitle.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 8),
            phoneTitle.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            phoneTitle.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
