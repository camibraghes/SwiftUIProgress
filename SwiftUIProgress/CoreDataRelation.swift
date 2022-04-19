//
//  CoreDataRelation.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 19.04.2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer.init(name: "")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data.\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data.\(error.localizedDescription)")
        }
    }
}

class CoreDataRelationViewModel: ObservableObject {
    let manager = CoreDataManager.instance
}

struct CoreDataRelation: View {
    
    @StateObject var viewModel = CoreDataRelationViewModel()
    
    var body: some View {
        Text("")
    }
}

struct CoreDataRelation_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelation()
    }
}
