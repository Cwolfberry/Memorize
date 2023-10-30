//
//  ContentView.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/30.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = ["🚕", "🛺", "🚔", "🚂", "🚗", "🚎", "🏎️", "🚓",
                    "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🚍",
                  "🚘", "🚖", "🚟", "🚃", "🚋", "🚝", "🚆", "🚇"]
    @State var emojisCount: Int = 10
    
    var body: some View {
        VStack {
            ScrollView {
                // [GridItem(), GridItem(), GridItem()] :  固定三行
                // [GridItem(.adaptive(minimum: 65))] : 最小宽度为65，根据屏幕（横向、竖向）自适应显示的item数量
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojisCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding()
        }
        .padding(.horizontal)
        
    }
    
    var remove: some View {
        Button(action: {
            emojisCount -= 1
        }, label: {
//            Text("remove")
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            emojisCount += 1
        }, label: {
//            Text("add")
            Image(systemName: "plus.circle")
        })
    }
}

struct CardView : View {
    var content: String = ""
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3) // stroke:向外延伸 | strokeBorder:向内延伸
                Text(content)
                    .font(.largeTitle)
            }
            else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

#Preview {
    ContentView()
//        .preferredColorScheme(.light)
//    ContentView()
//        .preferredColorScheme(.dark)
}
