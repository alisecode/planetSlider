//
//  Home.swift
//  PlanetSlider
//
//  Created by Alisa Serhiienko on 29.02.2024.
//

import SwiftUI

struct MilkyWay: View {
    @State var offsetY: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let planetSize = size.width

            VStack {
                ForEach(planets) { planet in
                    PlanetView(planet: planet, size: size)
                }
            }
            .frame(width: size.width)
            .padding(.top, size.height - planetSize)
            .offset(y: offsetY)
            .offset(y: -CGFloat(currentIndex) * planetSize)
        }
        .coordinateSpace(name: "Scroll")
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged({ value in
                    offsetY = value.translation.height * 0.5
                })
                .onEnded({ value in
                    let translation = value.translation.height
                    
                    withAnimation(.easeInOut) {
                        if translation > 0 {
                            if currentIndex > 0 && translation > 250 {
                                currentIndex -= 1
                            }
                        } else {
                            if currentIndex < planets.count - 1 && -translation > 250 {
                                currentIndex += 1
                            }
                        }
                        offsetY = .zero
                    }
                })
        )
        .overlay(alignment: .top) {
            VStack {
                Text(planets[currentIndex].title)
                    .font(.title).bold()
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(6)
                
                Text(planets[currentIndex].description)
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 24)
            
        }
     
    }

}


#Preview {
    MilkyWay()
}

struct PlanetView: View {
    var planet: Planet
    var size: CGSize
    
    var body: some View {
        let planetSize = size.width
        let maxSize = size.width * 2.8
        
        GeometryReader { proxy in
            let psize = proxy.size
            let offset = proxy.frame(in: .named("Scroll")).minY - (size.height - planetSize)
            
            let scale = offset <= 0 ? (offset / maxSize) : 0
            let reducedScale = 1 + scale
            let currentScale = offset / planetSize
            
            let aspectRatio: ContentMode = planet.title == "Saturn" ? .fill : .fit
            
            Image(planet.title)
                .resizable()
                .aspectRatio(contentMode: aspectRatio)
                .frame(width: psize.width, height: psize.height)
                .scaleEffect(reducedScale < 0 ? 0.004 : reducedScale, anchor: .init(x: 0.5, y: 1 - (currentScale / 1.8)))
                .scaleEffect(offset > 0 ? 1 + currentScale : 1, anchor: .top)
                .offset(y: offset > 0 ? currentScale * 200 : 0)
            
        }
        .frame(height: size.width)
    }
}

