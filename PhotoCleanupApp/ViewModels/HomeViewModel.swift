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

    init(photoLibraryService: PhotoLibraryService? = nil) {
        // A default *parameter value* that constructs a @MainActor type runs in
        // a separate, non-isolated context and fails to compile — constructing
        // it here in the init body (which inherits @MainActor from the class)
        // avoids that.
        self.photoLibraryService = photoLibraryService ?? PhotoLibraryService()
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
