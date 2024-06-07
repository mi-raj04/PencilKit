//
//  ViewController.swift
//  PencilKitDemo
//
//  Created by mind on 06/06/24.
//

import UIKit
import PencilKit

class ViewController: UIViewController,PKCanvasViewDelegate {
    @IBOutlet weak var canvasView: PKCanvasView!
    let toolPicker = PKToolPicker.init()
    var isNew = true
    var nameOfFile = ""

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCanvasView()
        loadDrawing(fileName: nameOfFile)
    }

    func setupCanvasView() {
        canvasView.delegate = self
        canvasView.isOpaque = true
        canvasView.becomeFirstResponder()
        canvasView.drawingPolicy = .anyInput
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.isRulerActive = false

    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("Drawing changed")
    }

    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("Finished rendering")
    }

    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("Began using tool")
    }

    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("Ended using tool")
    }
    
    @IBAction func SaveDrawingTap(_ sender: Any) {
        saveDrawing()
    }
    
    func saveDrawing() {
        let drawing = canvasView.drawing
        let data = drawing.dataRepresentation()
        let fileName = nameOfFile.count > 0 ? nameOfFile : generateFileName()
          if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
              let fileURL = directory.appendingPathComponent(fileName)
              do {
                  try data.write(to: fileURL)
                  print("Drawing saved at \(fileURL)")
              } catch {
                  print("Error saving drawing: \(error)")
              }
          }
      }

      func loadDrawing(fileName: String) {
          if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
              let fileURL = directory.appendingPathComponent(fileName)
              do {
                  let data = try Data(contentsOf: fileURL)
                  let drawing = try PKDrawing(data: data)
                  canvasView.drawing = drawing
                  print("Drawing loaded from \(fileURL)")
              } catch {
                  print("Error loading drawing: \(error)")
              }
          }
      }

      func generateFileName() -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyyMMdd_HHmmss"
          let dateString = formatter.string(from: Date())
          return "drawing_\(dateString).data"
      }
}

