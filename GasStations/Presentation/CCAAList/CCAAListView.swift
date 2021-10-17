import SwiftUI

struct CCAAListView: View {
    @ObservedObject private var viewModel = CCAAListViewModel()
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(viewModel.elements) { currentCCAA in
                CCAAElementRow(elem: currentCCAA) { selectedElement in
                    self.contentViewModel.selectedCCAA = selectedElement
                    self.contentViewModel.selectedProvince = nil
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Comunidades Autónomas")
        .onAppear {
            viewModel.getCCAAs()
        }
    }
}

struct CCAAElementRow: View {
    var elem: DomainCCAA
    let onTap: (DomainCCAA) -> Void

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
