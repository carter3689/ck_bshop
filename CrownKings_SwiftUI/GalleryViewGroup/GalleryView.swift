//
//  GalleryView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI
import FirebaseStorage



// Custom Struct to make the index identifiable
struct ImageIndex: Identifiable {
    let id: Int //the index itself will be the unique identifier
}


struct GalleryView: View {
    @State var photos = [String]()
    @State private var images: [UIImage] = []
    @State private var isShowingSheet = false
    @State private var isIndex: Int = 0
    @State private var selectedImage: UIImage?
    @State private var selectedImageIndex: ImageIndex? = nil //Store the index of the selected image
    @State private var hasFetchedImages = false // New Stat variable to track fetching
    
    @Environment(\.dismiss) private var dismiss
    
    private let storage = Storage.storage()
    
    func fetchImagesSorted() {
        let storageRef = storage.reference()
        let imagesFolderRef = storageRef.child("images/")
        
        imagesFolderRef.listAll { (result, error) in
            if let error = error {
                print("Error listing images: \(error.localizedDescription)")
            } else {
                // Sort items by name (assuming file names having meaningful names
                let sortedItems = result!.items.sorted { $0.name < $1.name }
                
                for item in sortedItems {
                    item.downloadURL { (url, error) in
                        if let error = error {
                            print("Error downloading image: \(error)")
                        } else if let url = url {
                            URLSession.shared.dataTask(with: url) {
                                data, _, error in
                                if let error = error {
                                    print("Error downloading image data: \(error)")
                                } else if let data = data, let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        images.append(image)
                                    }
                                }
                            }.resume()
                        }
                    }
                }
            }
        }
    }
    
    func fetchImages() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        //Reference to a folder in Firebase Storage
        let imagesFolderRef = storageRef.child("images/")
        
        //List all items(files) in the folder
        imagesFolderRef.listAll{ (result, error) in
            if let error = error {
                print("Error listing images: \(error)")
            } else {
                for item in result!.items {
                    //Get the download URL for each image
                    item.downloadURL() { (url, error) in
                        if let error = error {
                            print("Error downloading image: \(error)")
                        } else if let url = url {
                            //Download the image data using the URL
                            URLSession.shared.dataTask(with: url) {
                                data, _, error in
                                if let error = error {
                                    print("Error downloading image data: \(error) ")
                                } else if let data = data, let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        images.append(image) // Add the images to the array (on main thread)
                                    }
                                }
                            }.resume()
                        }
                    }
                }
            }
        }
    }
    
    //Function to save image to a temporary file
    func saveImageToTempFile(_ imageData: Data) -> URL? {
        let tempDirectoryURL = URL (fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        do {
            try imageData.write(to: tempFileURL)
            return tempFileURL
        } catch {
            print("Error saving image to temporary file: \(error)")
            return nil
        }
    }
    
    func getDownloadURl() -> [String] {
            var photoURLS = [String]()
            let ref = Storage.storage().reference()
            
            let storageReference = ref.child("images/")
            storageReference.listAll { (result, error) in
              if let error = error {
                print(error)
              }
                for item in result!.items {
                //List storage reference
                let storageLocation = String(describing: item)
                let gsReference = Storage.storage().reference(forURL: storageLocation)
                
                // Fetch the download URL
                gsReference.downloadURL { url, error in
                  if let error = error {
                    // Handle any errors
                    print(error)
                  } else {
                    // Get the download URL for each item storage location
                    print(url!)
                    print(type(of: url!))
                    print(type(of: url!.absoluteString))
                      photoURLS.append(url!.absoluteString)
                      print(photoURLS)
                    photos = photoURLS
                  }
                }
                
                
              }
            }
            return photoURLS
        }
    
    func didDismiss(){
        print("you are dismissed")
    }
    
    func setIndex(index: Int) {
        isIndex = index
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed(100)),
                    GridItem(.fixed(100)),
                ], spacing: 16, content:{
                    
                    //testing
                    ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                        if let imageData = image.jpegData(compressionQuality: 0.8),
                           let imageURL = saveImageToTempFile(imageData) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .onTapGesture {
                                selectedImageIndex = ImageIndex(id: index)
                                print("Selected image index:", selectedImageIndex!)//Set selected image
                            }
                        }
                    }
                }).sheet(item: $selectedImageIndex, onDismiss: didDismiss) { imageIndex in
                    Image(uiImage: images[imageIndex.id])
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("Swipe Down to dismiss larger imaage")
                        .font(.footnote)
                    
                }
            }.navigationTitle("Gallery")
                .onAppear{
                    if !hasFetchedImages { //Check if images have already been fetched
                        fetchImagesSorted()
                        hasFetchedImages = true // Mark images as fetched
                    }
                }
        }
    }
}

#Preview {
    GalleryView()
}
