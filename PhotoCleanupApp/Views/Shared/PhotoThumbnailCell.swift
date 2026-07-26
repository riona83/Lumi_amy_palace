import Photos
import SwiftUI

struct PhotoThumbnailCell: View {
    let asset: PHAsset
    let loadThumbnail: (PHAsset, CGSize, @escaping (UIImage?) -> Void) -> Void

    @State private var image: UIImage?

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle().fill(.quaternary)
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .onAppear {
                let scale = UIScreen.main.scale
                let targetSize = CGSize(width: proxy.size.width * scale, height: proxy.size.height * scale)
                loadThumbnail(asset, targetSize) { loadedImage in
                    image = loadedImage
                }
            }
        }
    }
}
