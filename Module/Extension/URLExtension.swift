//
//  URLExtension.swift
//  LS
//
//  Created by Tinh Nguyen on 24/11/2023.
//

import UIKit
import AVFoundation

extension URL {
    func generateThumbnail() -> UIImage? {
            do {
                let asset = AVURLAsset(url: self)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                
                // Swift 5.3
                let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                             actualTime: nil)

                return UIImage(cgImage: cgImage)
            } catch {
                print(error.localizedDescription)

                return nil
            }
        }
}
