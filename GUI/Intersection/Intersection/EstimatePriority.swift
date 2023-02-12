import SwiftUI

struct EstimatePriority: View {
    
    let NUMBER_OF_LANES = 1;
    @Binding var intersection:[Road]
    @State private var priority:Int = 1
    @State var temp: [Road] = []
    
    @State private var car1: CGFloat = 100
    @State private var car2: CGFloat = 100
    @State private var car3: CGFloat = 220
    @State private var car4: CGFloat = 220
    
    private func estimate(){
        for _ in 0...intersection.count-1 {
            var emergencyRoadIndex: [Int] = [];
            var busiestRoadIndex: [Int] = [];
            var nearestIndex:[Int] = [];
            
            var numberOfCars = NUMBER_OF_LANES + 1;
            var remainingTime = 1000;
            
            //Get Highest Priority
            for i in 0...intersection.count-1{
                if(intersection[i].hasEmergencyCar){
                    emergencyRoadIndex.append(i);
                }
                
                if(intersection[i].numberOfCars >= numberOfCars){
                    if(intersection[i].numberOfCars != numberOfCars){
                        busiestRoadIndex.removeAll();
                    }
                    busiestRoadIndex.append(i);
                    numberOfCars = intersection[i].numberOfCars;
                }
                
                if(intersection[i].remainingTime <= remainingTime){
                    if(intersection[i].remainingTime != remainingTime){
                        nearestIndex.removeAll()
                    }
                    nearestIndex.append(i);
                    remainingTime = intersection[i].remainingTime;
                }
            }
            
            //Assign priorities to Roads
            if(emergencyRoadIndex.count == 1){
                intersection[emergencyRoadIndex[0]].priority = priority;
                priority = priority + 1;
            }
            else if (emergencyRoadIndex.count>1){
                var minDistanceIndex = emergencyRoadIndex[0];
                for i in 0...emergencyRoadIndex.count-1 {
                    if(intersection[emergencyRoadIndex[i]].remainingTime<intersection[emergencyRoadIndex[minDistanceIndex]].remainingTime){
                        minDistanceIndex = i;
                    }
                }
                intersection[emergencyRoadIndex[minDistanceIndex]].priority = priority;
                priority = priority + 1;
            }
            else{
                if(busiestRoadIndex.count == 1){
                    intersection[busiestRoadIndex[0]].priority = priority;
                    priority = priority + 1;
                }
                else if (busiestRoadIndex.count > 1){
                    var minDistanceIndex=busiestRoadIndex[0];
                    for i in 0...busiestRoadIndex.count-1 {
                        if(intersection[busiestRoadIndex[i]].remainingTime<intersection[busiestRoadIndex[minDistanceIndex]].remainingTime){
                            minDistanceIndex = i;
                        }
                    }
                    intersection[busiestRoadIndex[minDistanceIndex]].priority = priority;
                    priority = priority + 1;
                }
                else{
                    intersection[nearestIndex[0]].priority = priority;
                    priority = priority + 1;
                }
            }
            
            //Append and remove prioritized Road from list
            temp.append(contentsOf: intersection.filter{ $0.priority != 0})
            intersection.removeAll{ $0.priority != 0}
        }
        
        checkParallelism()
        temp.sort{$0.name.last! < $1.name.last!}
        
        animate()
    }


private func checkParallelism(){
    var cur = temp[0].priority;
    for (i, road) in temp.enumerated(){
        if i<temp.count-1 {
            if road.name.hasSuffix("1") && temp[i+1].name.hasSuffix("3") || road.name.hasSuffix("3") && temp[i+1].name.hasSuffix("1") || road.name.hasSuffix("2") && temp[i+1].name.hasSuffix("4") || road.name.hasSuffix("4") && temp[i+1].name.hasSuffix("2") {
                if road.priority > 1 {
                    temp[i].priority = cur;
                }
                temp[i+1].priority = temp[i].priority
                
            }
            else{
                cur += 1
            }
        }
        else{
            temp[i].priority = cur
        }
    }
}

private func checkEmptyRoad(){
    if(!intersection.contains(where: { r in
        r.name.hasSuffix("1")
    })){
        car1 = 0
    }
    if(!intersection.contains(where: { r in
        r.name.hasSuffix("2")
    })){
        car2 = 0
    }
    if(!intersection.contains(where: { r in
        r.name.hasSuffix("3")
    })){
        car3 = 0
    }
    if(!intersection.contains(where: { r in
        r.name.hasSuffix("4")
    })){
        car4 = 0
    }
}


private func animate(){
    for i in temp {
        if i.name.hasSuffix("1"){
            withAnimation(Animation.easeIn(duration: 0.5).delay(Double(i.priority-1)/2)) {
                car1 = car1 + 200;
            }
        }
        if i.name.hasSuffix("2") {
            withAnimation(Animation.easeIn(duration: 0.5).delay(Double(i.priority-1)/2)) {
                car2 = car2 + 200;
            }
            
        }
        if i.name.hasSuffix("3") {
            withAnimation(Animation.easeIn(duration: 0.5).delay(Double(i.priority-1)/2)) {
                car3 = car3 - 200;
            }
            
        }
        if i.name.hasSuffix("4") {
            withAnimation(Animation.easeIn(duration: 0.5).delay(Double(i.priority-1)/2)) {
                car4 = car4 - 200;
            }
        }
    }
}

var body: some View {
    VStack{
        Text("Car Priority Algorithm").font(.title).bold().padding(.bottom, 20)
        Button("Estimate priority") { estimate() }.padding(.bottom, 40)
        
        RoadView(car1: $car1, car2: $car2, car3: $car3, car4: $car4)
        HStack{
            ForEach(temp.isEmpty ? intersection: temp, id: \.id) { road in
                VStack{
                    Text("Name: \(road.name)").padding(.bottom, 0.5)
                    Text("Number of cars: \(road.numberOfCars)").padding(.vertical, 0.5)
                    Text("Remaining time: \(road.remainingTime)").padding(.vertical, 0.5)
                    Text("Emergency car: \(String(road.hasEmergencyCar))").padding(.vertical, 0.5)
                    Text("Priority: \(road.priority)").bold().padding(.top, 0.5)
                }
                .padding(.vertical)
            }
        }
        .padding(.vertical)
    }.onAppear {
        checkEmptyRoad()
    }
    
}
}
