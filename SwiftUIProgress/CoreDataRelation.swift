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
        container = NSPersistentContainer.init(name: "CoreDataContainer")
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
                print("Saved Successfully")
        } catch let error {
                print("Error saving Core Data.\(error.localizedDescription)")
        }
    }
}

class CoreDataRelationViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching.\(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
        
        //add existing depatments to the new business:
        //newBusiness.department = []
        
        //add existing employee to the new business:
        //newBusiness.employee = []

        //add new business to existing depatments:
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        //add new business to existing employee:
        //newBusiness.addToEmployess(<#T##value: EmployeeEntity##EmployeeEntity#>)


    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func save() {
        businesses.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
        }
     
    }
}

struct CoreDataRelation: View {
    
    @StateObject var viewModel = CoreDataRelationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Button {
                        viewModel.addDepartment()
                    } label: {
                        Text("Perform Action")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.businesses) { buisness in
                                BusinessView(entity: buisness)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelation_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelation()
    }
}

struct BusinessView: View {
        
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "" )")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employess?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "" )
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

