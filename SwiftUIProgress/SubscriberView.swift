//
//  SubscriberView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 06.05.2022.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
        //            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self  else {return}
                self.count += 1
                
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else {return}
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberView: View {
    
    @StateObject var viewModel = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.title)
            Text(viewModel.textIsValid.description)
            TextField(" Type somethig here...", text: $viewModel.textFieldText)
                .frame(height: 60)
                .font(.headline)
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.red)
                            .opacity(viewModel.textFieldText.count < 1 ? 0 : viewModel.textIsValid ? 0 : 1)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .opacity(viewModel.textIsValid ? 1 : 0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
            Button {} label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .opacity(viewModel.showButton ? 1 : 0.5)
            }
            .disabled(!viewModel.showButton)
        }
        .padding(.horizontal)
    }
}

struct SubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberView()
    }
}
