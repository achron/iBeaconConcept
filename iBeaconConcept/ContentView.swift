//
//  ContentView.swift
//  iBeaconConcept
//
//  Created by user261874 on 7/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel(uuids: ["39ED98FF-2900-441A-802F-9C398FC199D2", "39ED98FF-2900-441A-802F-9C398FC199D3","39ED98FF-2900-441A-802F-9C398FC199D4"])
    
    var body: some View {
        VStack {
            HStack(spacing: 30)  {
                VStack {
                    Text(!viewModel.isActive ? "Start" : "Stop")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            debugPrint(!viewModel.isActive ? "Start" : "Stop")
                            if !viewModel.isActive {
                                viewModel.start()
                            } else {
                                viewModel.stop()
                            }
                        }
                        .font(.title)
                }
                VStack {
                    Text(!viewModel.isSorted ? "Sort" : "Sorted")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            debugPrint(!viewModel.isSorted ? "Start" : "Stop")
                            viewModel.sort()
                        }
                        .font(.title)
                        .foregroundColor(.black)
                    }
                    .background(.clear)

                VStack {
                    Text(!viewModel.isFilter ? "Only Beacon" : "All")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            viewModel.isFilter.toggle()
                        }
                        .font(.title)
                        .foregroundColor(.black)
                }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            List(viewModel.beaconsToRange, id: \.self) { beacon in
                Row(uuid: beacon.uuid.uuidString, distance: beacon.minor!.stringValue)
            }
            .background(.clear)
//            List{
//                Row(uuid: "Test", distance: "15")
//            }
//            .background(.clear)
            Spacer()
        }
}


struct Row: View {
    @State var uuid: String = ""
    @State var distance: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 15) {
                HStack {
                    Image("globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .frame(width: 40, height: 40)
                .background(.white)
                .clipShape(Circle())
                Text(uuid)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                Text(distance)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .frame(height: 91)
            .padding(.horizontal, 15)
        }
        .frame(maxWidth: .infinity, minHeight: 150
               , alignment: .leading)
        .padding([.horizontal], 15)
        .cornerRadius(19)
    }
}

#Preview {
    ContentView()
}
