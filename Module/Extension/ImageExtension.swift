//
//  ImageExtension.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit
import AVFoundation
import Photos


let imageCache = NSCache<AnyObject, AnyObject>()
let imageCacheV2 = NSCache<AnyObject, AnyObject>()

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    func resizeImage(scale: CGFloat) -> UIImage {
        let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: lineHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func convertImageToBase64String() -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func mask(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        color.setFill()
        self.draw(in: rect)
        
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
}

extension UIImageView {
    func changeToColor(_ color: UIColor) {
        if let image = self.image {
            self.tintColor = color
            self.image = image.withRenderingMode(.alwaysTemplate)
        }
    }
    
//    func load(urlString: String) {
//        DispatchQueue.global(qos: .background).async {
//            do{
//                if urlString != "" {
//                    let data = try Data.init(contentsOf: URL.init(string: urlString)!)
//                    DispatchQueue.main.async {
//                        let image: UIImage? = UIImage(data: data)
//                        self.image = image
//                    }
//                }
//                else {
//                    DispatchQueue.main.async {
//                        let image: UIImage? = UIImage(named: "img_thumbnail")
//                        self.image = image
//                    }
//                }
//            }
//            catch let errorLog {
//                debugPrint(errorLog.localizedDescription)
//            }
//        }
//    }
    
    func generateQRCode(from string: String) {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)

            if let output = filter.outputImage?.transformed(by: transform) {
                image = UIImage(ciImage: output)
            }
        }
    }
    

    
    func loadThumbnail(_ urlString: String, img_thumbnail: String, result: @escaping(AVAsset?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let assetVideo: AVAsset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: assetVideo)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: 100, height: 100)
        result(assetVideo)
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        
        do {
            if let cachedImage = imageCache.object(forKey: url.absoluteString as AnyObject) {
                DispatchQueue.main.async {
                    self.image = cachedImage as? UIImage
                }
                
                return
            } else {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                imageCache.setObject(thumbnail, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = thumbnail
                }
            }
        } catch {
//            print("Error while loading video thumbnail: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.image = UIImage(named: img_thumbnail)
            }
        }
    }
    
    func loadThumbnailV2(urlString: String, img_thumbnail: String) {
        if urlString == "" {
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.image = nil
        }
        
        if let imageFromCache = imageCacheV2.object(forKey: urlString as AnyObject) {
            DispatchQueue.main.async {
                self.image = imageFromCache as? UIImage
            }
            
            return
        }
        
        Networking.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else { return }
                    imageCacheV2.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage(named: img_thumbnail)
                }
            }
        }
    }
}
