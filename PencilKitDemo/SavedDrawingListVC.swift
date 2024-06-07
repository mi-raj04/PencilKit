//
//  SavedDrawingListVC.swift
//  PencilKitDemo
//
//  Created by mind on 07/06/24.
//

import UIKit

class SavedDrawingListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tblView: UITableView!
    var savedDrawings: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedDrawings()
    }
    
    func loadSavedDrawings() {
         savedDrawings.removeAll()
         if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
             do {
                 let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
                 for file in files {
                     if file.pathExtension == "data" {
                         savedDrawings.append(file.lastPathComponent)
                     }
                 }
                 tblView.reloadData()
             } catch {
                 print("Error loading saved drawings: \(error)")
             }
         }
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedDrawings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = savedDrawings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.isNew = false
        vc.nameOfFile = savedDrawings[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fileName = savedDrawings[indexPath.row]
            deleteDrawing(fileName: fileName)
            savedDrawings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func deleteDrawing(fileName: String) {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent(fileName)
            do {
                try FileManager.default.removeItem(at: fileURL)
                print("Drawing deleted at \(fileURL)")
            } catch {
                print("Error deleting drawing: \(error)")
            }
        }
    }
}
