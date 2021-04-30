//
//  ToastView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/22.
//

import SwiftUI

struct ToastView<Presenting, Content>: View where Presenting: View, Content: View {
    @Binding var isPresented: Bool
    let presenter: () -> Presenting
    let content: () -> Content
    let delay: TimeInterval = 2

    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }

        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenter()

                ZStack {
                    Capsule()
                        .fill(Color.gray)

                    self.content()
                } //ZStack (inner)
                .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                .opacity(self.isPresented ? 1 : 0)
            } //ZStack (outer)
            .padding(.bottom)
        } //GeometryReader
    } //body
} //Toast



extension View {
    func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        ToastView(
            isPresented: isPresented,
            presenter: { self },
            content: content
        )
    }
}
class ToastViewModel:ObservableObject{
    @Published var text = String()
    @Published var display = false
    
    
}


//struct ToastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToastView<<#Presenting: View#>, <#Content: View#>>()
//    }
//}
