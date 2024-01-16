

import Foundation

struct DailyWaterIntake {
    var date: String
    var totalIntake: Int
}

class User: ObservableObject {
    static let shared = User()
    var username: String = ""
    var waterConsumtionPerDay = 0
    var waterIntakeHistory:[DailyWaterIntake] = []
}
