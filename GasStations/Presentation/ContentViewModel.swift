import Foundation
import Combine
import CoreLocation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var selectedCCAA: DomainCCAA?
    @Published var selectedProvince: DomainProvince?
    @Published var selectedProduct: DomainProduct?
}
