//
//  RoadView.swift
//  Intersection
//
//  Created by Zaur Gurbanli on 12.01.23.
//

import SwiftUI

struct RoadView: View {
    @Binding var car1: CGFloat
    @Binding var car2: CGFloat
    @Binding var car3: CGFloat
    @Binding var car4: CGFloat
    
    var body: some View {
        VStack{
            Image("Road").resizable().frame(width: 320, height: 320).overlay {
                Image("Car1").resizable().frame(width: 40, height: 40).rotationEffect(.degrees(90)).position(x: car1, y: 175).opacity(car1 == 0 ? 0 : 1)
                Image("Car2").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40).rotationEffect(.degrees(-90)).position(x: 145, y: car2).opacity(car2 == 0 ? 0 : 1)
                Image("Car3").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40).position(x: car3, y: 145).opacity(car3 == 0 ? 0 : 1)
                Image("Car4").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40).position(x: 175, y: car4).opacity(car4 == 0 ? 0 : 1)
            }
           
        }
        
    }
}

//struct RoadView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoadView()
//    }
//}
