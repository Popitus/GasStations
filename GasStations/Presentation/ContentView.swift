import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    private var ccaaTitleText: String {
        viewModel.selectedCCAA?.name ?? "Select a CCAA"
    }
    
    private var provinceTitleText: String {
        viewModel.selectedProvince?.name ?? "Select a Province"
    }
    
    private var productTitleText: String {
        viewModel.selectedProduct?.name ?? "Select a Product"
    }
        
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Regions")) {
                    NavigationLink(destination: CCAAListView()) {
                        Text(ccaaTitleText)
                    }
                    NavigationLink(destination: ProvinceListView()) {
                        Text(provinceTitleText)
                    }
                    .disabled(viewModel.selectedCCAA == nil)
                }

                Section(header: Text("Product")) {
                    NavigationLink(destination: ProductsListView()) {
                        Text(productTitleText)
                    }
                }
                
                Section(header: Text("Go")) {
                    NavigationLink(destination: GasStationsListView()) {
                        Text("Show gas stations!")
                    }
                    .disabled((viewModel.selectedProvince == nil) || (viewModel.selectedProduct == nil))
                }
            }
        }
        .environmentObject(viewModel)
    }
}
