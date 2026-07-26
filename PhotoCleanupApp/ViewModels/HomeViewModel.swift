import Foundation
import Photos
import UIKit

@MainActor
@Observable
final class HomeViewModel {
    private let photoLibraryService: PhotoLibraryService

    var accessStatus: PhotoLibraryAccessStatus { photoLibraryService.accessStatus }
    var assets: [PHAsset] { photoLibraryService.assets }
    var photoCount: Int { assets.count }

    init(photoLibraryService: PhotoLibraryService = PhotoLibraryService()) {
        self.photoLibraryService = photoLibraryService
    }

    func onAppear() async {
        await photoLibraryService.requestAccessIfNeeded()
    }

    func presentLimitedLibraryPicker() {
        photoLibraryService.presentLimitedLibraryPicker()
    }

    func thumbnail(for asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        photoLibraryService.thumbnail(for: asset, targetSize: targetSize, completion: completion)
    }
}
