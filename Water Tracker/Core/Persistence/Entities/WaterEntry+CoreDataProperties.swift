
import Foundation
import CoreData

@objc(WaterEntry)
public class WaterEntry: NSManagedObject {

}


extension WaterEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterEntry> {
        return NSFetchRequest<WaterEntry>(entityName: "WaterEntry")
    }

    @NSManaged public var id: String?
    @NSManaged public var remaining: Int64
    @NSManaged public var amount: Int64
    @NSManaged public var createdAt: Date?

}

extension WaterEntry : Identifiable {

}
