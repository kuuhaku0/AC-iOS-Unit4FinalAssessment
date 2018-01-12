//
//  FileManager.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Foundation

class DataStore {
    
    static let kPathname = "customAnimations.plist"
    
    // singleton
    private init(){}
    static let manager = DataStore()
    
    private var customAnimations = [Animation]() {
        didSet{
            saveToDisk()
        }
    }
    
    // returns documents directory path for app sandbox
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // /documents/Favorites.plist
    // returns the path for supplied name from the dcouments directory
    func dataFilePath(withPathName path: String) -> URL {
        return DataStore.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    // save to documents directory
    // write to path: /Documents/
    func saveToDisk() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(customAnimations)
            // Does the writing to disk
            try data.write(to: dataFilePath(withPathName: DataStore.kPathname), options: .atomic)
        } catch {
            print("encoding error: \(error.localizedDescription)")
        }
        print("\n==================================================")
        print(documentsDirectory())
        print("===================================================\n")
    }
    
    // load from documents directory
    func load() {
        // what's the path we are reading from?
        let path = dataFilePath(withPathName: DataStore.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            customAnimations = try decoder.decode([Animation].self, from: data)
        } catch {
            print("decoding error: \(error.localizedDescription)")
        }
    }
    
    func addToCustomAnimations(animation: Animation) -> Bool  {
        // checking for uniqueness
        let indexExist = self.customAnimations.index{ $0.animationName == animation.animationName }
        if indexExist != nil { print("FAVORITE EXIST"); return false }
        
        // 2) save favorite object
        let newAnimation = animation
        self.customAnimations.append(newAnimation)
        return true
    }
    
//    func isAnimationInCustomAnimations(animation: Animation) -> Bool {
//        // checking for uniqueness
//        let indexExist = self.favorites.index{ $0 == favorites.id }
//        if indexExist != nil {
//            return true
//        } else {
//            return false
//        }
//    }
    
    //    func getFavoriteWithId(id: String) -> Favorite? {
    //        let index = getFavorites().index{$0.id == id}
    //        guard let indexFound = index else { return nil }
    //        return favorites[indexFound]
    //    }
    
    func getAnimations() -> [Animation] {
        return customAnimations
    }
    
    func removeAnimation(fromIndex index: Int, andAnimation animation: Animation) -> Bool {
        customAnimations.remove(at: index)
        return true
    }
}
