import Foundation

struct Road: Identifiable {
    var id = UUID().uuidString;
    var numberOfCars: Int = 0;
    var remainingTime: Int = 0;
    var hasEmergencyCar: Bool = false;
    var priority:Int = 0;
    var name: String = "";
    
    init(numberOfCars: Int, remainingTime: Int, hasEmergencyCar: Bool, name: String) {
        self.numberOfCars = numberOfCars
        self.remainingTime = remainingTime
        self.hasEmergencyCar = hasEmergencyCar
        self.name = name
    }
};
