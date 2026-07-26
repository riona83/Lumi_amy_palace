import Photos
import UIKit

enum PhotoLibraryAccessStatus {
    case notDetermined
    case authorized
    case limited
    case denied
}

/// Wraps PHPhotoLibrary/PHCachingImageManager: authorization, asset
/// enumeration, and thumbnail loading. Later milestones extend this with
/// delete and album-creation methods.
@MainActor
@Observable
final class PhotoLibraryService {
    private(set) var accessStatus: PhotoLibraryAccessStatus = .notDetermined
    private(set) var assets: [PHAsset] = []

    private let cachingImageManager = PHCachingImageManager()

    func requestAccessIfNeeded() async {
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if currentStatus == .notDetermined {
            let newStatus = await withCheckedContinuation { continuation in
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    continuation.resume(returning: status)
                }
            }
            apply(newStatus)
        } else {
            apply(currentStatus)
        }
    }

    private func apply(_ status: PHAuthorizationStatus) {
        switch status {
        case .authorized:
            accessStatus = .authorized
            fetchAssets()
        case .limited:
            accessStatus = .limited
            fetchAssets()
        case .denied, .restricted:
            accessStatus = .denied
        case .notDetermined:
            accessStatus = .notDetermined
        @unknown default:
            accessStatus = .denied
        }
    }

    private func fetchAssets() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = PHAsset.fetchAssets(with: .image, options: options)

        var fetched: [PHAsset] = []
        fetched.reserveCapacity(result.count)
        result.enumerateObjects { asset, _, _ in fetched.append(asset) }
        assets = fetched
    }

    func presentLimitedLibraryPicker() {
        guard
            let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let root = scene.windows.first?.rootViewController
        else { return }
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: root)
    }

    /// Requests a modestly-sized thumbnail. Never requests full-resolution
    /// originals here, and skips iCloud downloads (isNetworkAccessAllowed = false).
    func thumbnail(for asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.resizeMode = .exact
        options.isNetworkAccessAllowed = false

        cachingImageManager.requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: .aspectFill,
            options: options
        ) { image, _ in
            completion(image)
        }
    }
}
