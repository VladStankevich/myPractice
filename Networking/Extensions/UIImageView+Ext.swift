import UIKit

extension UIImageView {
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) {
        self.image = nil
        
        let imageCashe = NSCache<NSString, UIImage>()
        let key = NSString(string: urlString)
        
        if let cachedImage = imageCashe.object(forKey: key) {
            self.image = cachedImage
            return
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                imageCashe.setObject(image, forKey: key)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        task.resume()
    }
    
}

