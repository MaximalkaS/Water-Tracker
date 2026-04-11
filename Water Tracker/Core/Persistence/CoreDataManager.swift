
import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    var waterEntries: [WaterEntry] { get }
    func fetchWaterEntries()
    func addWaterEntry(for entry: WaterEntry)
    func deleteWaterEntry(with id: String)
}

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let viewContext: NSManagedObjectContext
    
    var waterEntries: [WaterEntry] = []
    
    private init() {
        viewContext = PersistenceController.shared.container.viewContext
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Ошибка при сохранении: \(error.localizedDescription)")
        }
    }
    
    func fetchWaterEntries() {
        let request = WaterEntry.fetchRequest()
        
        do {
            let waterEntries = try viewContext.fetch(request)
            self.waterEntries = waterEntries
        } catch {
            print("Failure to fetch water entries: \(error.localizedDescription)")
        }
    }
    
    func addWaterEntry(for entry: WaterEntry) {
        let newEntry = WaterEntry(context: viewContext)
        newEntry.id = UUID().uuidString
        newEntry.amount = entry.amount
        newEntry.remaining = entry.remaining
        newEntry.createdAt = Date()
        
        saveContext()
        fetchWaterEntries()
    }
    
    func deleteWaterEntry(with id: String) {
        let request = WaterEntry.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try viewContext.fetch(request)
            
            if let deleteEntry = result.first {
                viewContext.delete(deleteEntry)
                try viewContext.save()
                fetchWaterEntries()
            }
        } catch {
            print("Failure to delete water entry: \(error.localizedDescription)")
        }
    }
}
