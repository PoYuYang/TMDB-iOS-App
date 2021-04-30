//
//  SearchView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/13.
//

import SwiftUI
import Kingfisher



struct SearchView: View {
    
    @ObservedObject var viewModel:SearchViewModel = SearchViewModel()
    @State private var searchText : String = ""

    var body: some View {
            NavigationView {
                VStack {
                    SearchBar(vm: self.viewModel, text: $searchText, placeholder: "Search Movies, TVs...")
                    SearchResultView(vm: self.viewModel)
                    .navigationBarTitle(Text("Search"))
                    
                    
                }
            }

    }
}


struct SearchBar: UIViewRepresentable {
    
    @ObservedObject var vm: SearchViewModel
    @Binding var text: String
    @State var isSearching = false
    var placeholder: String
    
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @ObservedObject var viewModel:SearchViewModel
        @Binding var text: String
        let debouncer = Debouncer(delay: 1)

        init(text: Binding<String>, vm: SearchViewModel) {
            _text = text
            self.viewModel = vm
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            text = searchText
            searchBar.showsCancelButton = true
            if(searchText.count >= 3){
                debouncer.run(action: {
                    self.viewModel.getSearchResult(name: self.text)
                })
                
            }
            
            
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
            text = ""
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            self.viewModel.results = [SearchRes]()
         
 
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }

        
    }


    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, vm: self.vm)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
//    @ObservedObject var viewModel = SearchViewModel()
//    @State var searchText = ""
//    @State var isSearching = false
//    var body: some View {
//        NavigationView {
//            ScrollView{
//                HStack {
//                    HStack {
//
//                        TextField("Search Movies, TVs...", text: $searchText)
//                            .padding(.leading,25)
//                    }
//                    .padding()
//                    .background(Color(.systemGray5))
//                    .cornerRadius(6)
//                    .padding(.horizontal)
//                    .onTapGesture(perform:{
//                        isSearching = true
//                    })
//
//
//                    .overlay(
//                        HStack {
//                            Image(systemName:"magnifyingglass")
//                            Spacer()
//
//                            if isSearching {
//                                Button(action: {searchText=""}, label:{
//                                    Image(systemName: "xmark.circle.fill")
//                                })
//                            }
//
//                        }.padding(.horizontal,32)
//                        .foregroundColor(.gray)
//                    ) .transition(.move(edge: .trailing))
//                    .animation(.spring())
//
//                    if isSearching{
//                    Button(action: {
//                            isSearching = false
//                            searchText = ""
//                            hideKeyboard()
//
//                    }, label:{
//                        Text("Cancel")
//                            .padding(.trailing)
//                            .padding(.leading,0)
//
//                    })
//                    .transition(.move(edge: .trailing))
//                    .animation(.spring())
//                    }
//                }
//
//
//            }
//            .navigationTitle("Search")
//        }
//    }
}


//inorder to dismiss keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif




struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
