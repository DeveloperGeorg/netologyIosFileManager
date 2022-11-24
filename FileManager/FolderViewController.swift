//
//  TableViewController.swift
//  FileManager
//
//  Created by Георгий Бондаренко on 14.11.2022.
//

import UIKit

class FolderViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    var contents: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path.path)
        } catch {
            return []
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerController.sourceType = .photoLibrary
        imagePickerController.isEditing = true
        imagePickerController.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = contents[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    @IBAction func addPicture(_ sender: Any) {
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let url = path.appendingPathComponent(UUID().uuidString + ".png")

            if let data = pickedImage.pngData() {
                do {
                    try data.write(to: url)
                } catch {
                    print("Unable to Write Image Data to Disk")
                }
            }
        }
        tableView.reloadData()
        dismiss(animated: true)
    }
}
