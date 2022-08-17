//
//  PointFileOperationHelper.swift
//  BlackJackGameProject
//
//  Created by Elif on 16.08.2022.
//

import Foundation

class FileOperationHelper {
    func writePointToFile(point: Int) {
        do {
            let currentPoint = readPointFromFile()
            let newPoint = currentPoint + point

            try "\(newPoint)".write(toFile: getFileURL(), atomically: true, encoding: .utf8)
        } catch {
            fatalError("File cannot write.")
        }
    }

    func readPointFromFile() -> Int {
        do {
            let text = try String(contentsOfFile: getFileURL(), encoding: .utf8)
            return Int(text)!
        } catch {
            fatalError("File cannot read.")
        }
    }
    
    func createFileIfNeeded() {
        let isFileExists = FileManager.default.fileExists(atPath: getFileURL())
        
        if isFileExists == false {
            try! "100".write(toFile: getFileURL(), atomically: true, encoding: .utf8)
        }
    }
    
    private func getFileURL() -> String {
        return FileManager.default.currentDirectoryPath + "/Data.txt"
    }
}
