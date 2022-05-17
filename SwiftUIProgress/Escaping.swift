//
//  Escaping.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 29.04.2022.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData5 { [weak self] (downloadedResult) in
            self?.text = downloadedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void)  {
        completionHandler("New data2!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New data3!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) ->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data 4")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data 5")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) ->()

struct Escaping: View {
    
    @StateObject var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.light)
            .foregroundColor(.orange)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

struct Escaping_Previews: PreviewProvider {
    static var previews: some View {
        Escaping()
    }
}
