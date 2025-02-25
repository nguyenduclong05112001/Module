//
//  PermissionManager.swift
//  LS
//
//  Created by macmini on 11/03/2024.
//

import Foundation
import Photos
import UIKit

enum GPSStatus {
    case gpsOff
    case enabled
    case notAllowed
    case notDetermined
    case notAlways
}

public class PermissionManager {
    public static let shared = PermissionManager()
    private init() {}
    
    public func checkPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            // User has authorized access to the photo library
            completion(true)
        case .denied, .restricted, .limited:
            // User has denied or restricted access to the photo library
            completion(false)
        case .notDetermined:
            // Request authorization
            PHPhotoLibrary.requestAuthorization { status in
                completion(status == .authorized)
            }
        @unknown default:
            fatalError("Unhandled case")
        }
    }
    
    public func showPhotosPermisstionAlert(from viewController: UIViewController) {
        let alertController = UIAlertController(title: "Permission Denied", message: "Please grant access to your photo library in Settings to proceed.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    public func checkCapturePermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            // User has authorized access to the photo library
            completion(true)
        case .denied, .restricted:
            // User has denied or restricted access to the photo library
            completion(false)
        case .notDetermined:
            // Request authorization
            AVCaptureDevice.requestAccess(for: .video) { Bool in
                completion(Bool)
            }
        @unknown default:
            fatalError("Unhandled case")
        }
    }
}
