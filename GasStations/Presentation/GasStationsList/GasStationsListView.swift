import SwiftUI

struct GasStationsListView: View {
    @ObservedObject private var viewModel = GasStationListViewModel()
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        List(viewModel.elements) { currentGasStation in
            GasStationElementRow(elem: currentGasStation)
        }
        .onAppear {
            guard let idProvince = contentViewModel.selectedProvince?.id,
                    let idProduct = contentViewModel.selectedProduct?.id else {
                        return
                    }
            
            viewModel.getGasStations(idProvince: idProvince, idProduct: idProduct)
        }
    }
}

struct GasStationElementRow: View {
    var elem: DomainGasStation

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(elem.price)€")
                .font(Font.title)
                .frame(maxWidth: .infinity, minHeight: 40, maxHeight: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .contentShape(Rectangle())
            Spacer()
                Text(elem.place)
                    .font(Font.caption)
                    .frame(maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .contentShape(Rectangle())
                Text(elem.address)
                .font(Font.caption2)
                    .frame(maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .contentShape(Rectangle())
        }
    }
}
