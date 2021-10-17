import SwiftUI
import Combine

struct ProductsListView: View {
    @ObservedObject private var viewModel = ProductListViewModel()
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(viewModel.elements) { currentProduct in
                ProductElementRow(elem: currentProduct) { selectedElement in
                    self.contentViewModel.selectedProduct = selectedElement
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("product_title")
        .onAppear {
            viewModel.getProducts()
        }
    }
}

struct ProductElementRow: View {
    var elem: DomainProduct
    let onTap: (DomainProduct) -> Void

    var body: some View {
        HStack {
            Text(elem.name)
                .frame(maxWidth: .infinity, minHeight: 80, maxHeight: .infinity)
            Spacer()
        }
        .onTapGesture {
            onTap(elem)
        }
    }
}
