//
//  Networking.swift
//  LS
//
//  Created by macmini on 25/11/2023.
//

import Foundation

public enum ImageResult<T> {
    case success(T)
    case failure(Error)
}

public class Networking: NSObject {
    public static let shared = Networking()
    // MARK: - Private functions
    private func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public function
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL,
                                     completion: @escaping (ImageResult<Data>) -> Void) {
        Networking.shared.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
