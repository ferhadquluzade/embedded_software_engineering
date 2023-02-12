//
//  ContentView.swift
//  Intersection
//
//  Created by Zaur Gurbanli on 10.01.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfCars: String = "";
    @State private var remainingTime: String = "";
    @State private var hasEmergencyCar: Bool = false;
    @State private var roadNumber: Int = 1;
    @State private var estimateScreen = false
    @State private var destination: String = ""
    
    
    @State private var intersection: [Road] = [];
    
    private func onButtonPressed()-> Void{
        let road = Road(numberOfCars: Int(numberOfCars)!, remainingTime: Int(remainingTime)!, hasEmergencyCar: hasEmergencyCar, name: "ROAD #\(roadNumber)");
        intersection.append(road)
        numberOfCars = "";
        remainingTime = "";
        hasEmergencyCar = false;
        roadNumber = roadNumber + 1;
        if(roadNumber > 4){
            estimateScreen = true;
            intersection = intersection.filter{$0.numberOfCars != 0}
            roadNumber = 1;
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Car Priority Algorithm").font(.title).bold().padding(.bottom, 36)

                Text("ROAD #\(roadNumber)")
                    .bold()
                    .font(.system(size: 16))
                HStack{
                    Text("Number of cars:").bold()
                    TextField("Enter interger", text: $numberOfCars)
                    
                }.padding(20)
                HStack{
                    Text("Remaining time:").bold()
                    TextField("Enter integer", text: $remainingTime)
                }
                .padding(20)
                
                Picker("Emergency car:", selection: $hasEmergencyCar) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                }.padding(20).bold()
                
//                HStack{
//                    Text("Destination:").bold()
//                    TextField("Enter integer", text: $destination)
//                }
//                .padding(20)
                Button {
                    onButtonPressed()
                } label: {
                    Text("Initialize road").padding(.horizontal, 5).bold()
                }.padding(.vertical)
                    .disabled(disabledButton(numberOfCars, remainingTime))
                if estimateScreen {
                    NavigationLink(destination: EstimatePriority(intersection: $intersection), label: {
                        Text("Show roads").padding(.horizontal, 5).bold()
                    })
                }
                else {}
                
            }.padding(20)
        }
        .navigationViewStyle(.automatic)
    }
}



func disabledButton(_ car: String, _ time: String) -> Bool {
    return car.isEmpty || time.isEmpty
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
