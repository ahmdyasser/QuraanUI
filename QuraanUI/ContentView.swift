//
//  ContentView.swift
//  QuraanUI
//
//  Created by Ahmad Yasser on 09/07/2021.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var networking = Networking()
    @State var ayahs = ""
    @State var buttonPressed = false
    @State var pageNumber = 600
    @State var name = ""
    @State var middleName = ""
    var test = "السلام عليكم"
    
    
  
    
    
    
    
    @State private var selectableText = true

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.999462322, blue: 0.9334084949, alpha: 1)))
            
            VStack {
             
                if buttonPressed {
                    Text(name)
                        
                        .font(.custom("_PDMS_Saleem_QuranFont", size: 34))
                   
                      
                        VStack(alignment: .trailing) {
                          Text(ayahs)
                            .font(.custom("KFGQPCHAFSUthmanicScript-Regula", size: 25))
                            .multilineTextAlignment(.trailing)
                           
                        }.padding(.horizontal)
                        
                    
                   
                }
                
                
               
             Spacer()
              
            }
            
        
                VStack {
                    Spacer()
                    if buttonPressed {
                       HStack {
                            Button(action: {
                                if pageNumber < 604 {
                                    pageNumber += 1
                                    networking.fechData(pageNumber: pageNumber) { (surahText, surahName, middleSurahName)  in
                                        ayahs = surahText
                                        name = surahName
                                }
                              
                                
                                    
                                }
                            }, label: {
                                Text("التالي")
                                  
                                    .font(.custom("Amiri-Regular", size: 25))
                                   
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(Color(.black))
                                    .cornerRadius(10)
                                    
                            })
                            Button(action: {
                                if pageNumber > 1 {
                                    pageNumber -= 1
                                    networking.fechData(pageNumber: pageNumber) { (surahText, surahName, middleSurahName)  in
                                        ayahs = surahText
                                        name = surahName
                                }
                              
                              
                                    
                                }
                            }, label: {
                                Text("السابق")
                                 
                                    .font(.custom("Amiri-Regular", size: 25))
                                   
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(Color(.black))
                                    .cornerRadius(10)
                        })

                    }
                    }
                    
                Button(action: {
                    buttonPressed = true
                    networking.fechData(pageNumber: pageNumber) { (surahText, surahName, middleSurahName)  in
                        ayahs = surahText
                        name = surahName
                        middleName = middleSurahName
                        
                    }
                }, label: {
                    Text("تحميل")
                   
                        .font(.custom("Amiri-Regular", size: 25))
                       
                        .foregroundColor(.white)
                        .frame(width: 60, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color(.black))
                        .cornerRadius(10)
            })
                
                
                }.opacity(0.9)
            if buttonPressed {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(pageNumber)".enToArDigits)
                            .font(.headline)
                            .padding(15)
                    }
                }
            }
           
        }.gesture(
            DragGesture(minimumDistance: 3.0, coordinateSpace: .local).onEnded({ value in
                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                        print("left swipe")
                    if pageNumber > 1 {
                        pageNumber -= 1
                        networking.fechData(pageNumber: pageNumber) { (surahText, surahName, middleSurahName)  in
                            ayahs = surahText
                            name = surahName
                            middleName = middleSurahName
                            
                        }
                    }
                    
                    }
                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                        print("right swipe")
                        if pageNumber < 604 {
                            pageNumber += 1
                            networking.fechData(pageNumber: pageNumber) { (surahText, surahName, middleSurahName)  in
                                ayahs = surahText
                                name = surahName
                                middleName = middleSurahName
                                
                            }
                        }
                    }
//                    else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
//                        print("up swipe")
//                    }
//                    else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
//                        print("down swipe")
//                    }
                    else {
                        print("no clue")
                    }
            })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//
///// This subclass is needed since we want to customize the cursor and the context menu
//class CustomUITextField: UITextField, UITextFieldDelegate {
//
//    /// Binding from the `CustomTextField` so changes of the text can be observed by `SwiftUI`
//    fileprivate var _textBinding: Binding<String>!
//
//    /// If it is `true` the text field behaves normally.
//    /// If it is `false` the text cannot be modified only selected, copied and so on.
//    fileprivate var _isEditable = true {
//        didSet {
//            // set the input view so the keyboard does not show up if it is edited
//            self.inputView = self._isEditable ? nil : UIView()
//            // do not show autocorrection if it is not editable
//            self.autocorrectionType = self._isEditable ? .default : .no
//        }
//    }
//
//
//    // change the cursor to have zero size
//    override func caretRect(for position: UITextPosition) -> CGRect {
//        return self._isEditable ? super.caretRect(for: position) : .zero
//    }
//
//    // override this method to customize the displayed items of 'UIMenuController' (the context menu when selecting text)
//
//
//    // === UITextFieldDelegate methods
//
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        // update the text of the binding
//        self._textBinding.wrappedValue = textField.text ?? ""
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Allow changing the text depending on `self._isEditable`
//        return self._isEditable
//    }
//
//}
//
//struct CustomTextField: UIViewRepresentable {
//
//    @Binding private var text: String
//    private var isEditable: Bool
//
//    init(text: Binding<String>, isEditable: Bool = true) {
//        self._text = text
//        self.isEditable = isEditable
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> CustomUITextField {
//        let textField = CustomUITextField(frame: .zero)
//        textField.delegate = textField
//        textField.text = self.text
//        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        return textField
//    }
//
//    func updateUIView(_ uiView: CustomUITextField, context: UIViewRepresentableContext<CustomTextField>) {
//        uiView.text = self.text
//        uiView._textBinding = self.$text
//        uiView._isEditable = self.isEditable
//    }
//
//    func isEditable(editable: Bool) -> CustomTextField {
//        return CustomTextField(text: self.$text, isEditable: editable)
//    }
//}
//
//struct SelectableText: UIViewRepresentable {
//
//    private var text: String
//    private var selectable: Bool
//
//    init(_ text: String, selectable: Bool = true) {
//        self.text = text
//        self.selectable = selectable
//    }
//
//    func makeUIView(context: Context) -> CustomUITextField {
//        let textField = CustomUITextField(frame: .zero)
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
//
//        textField.delegate = textField
//        textField.text = self.text
//        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        textField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        textField.font = UIFont(name: "_PDMS_Saleem_QuranFont", size: 25)
//        textField.layoutMargins = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
//
//        textField.leftView = paddingView;
//        textField.rightView = paddingView;
//        textField.leftViewMode = .always
//        textField.rightViewMode = .always
//
//        return textField
//    }
//
//    func updateUIView(_ uiView: CustomUITextField, context: Context) {
//        uiView.text = self.text
//        uiView._textBinding = .constant(self.text)
//        uiView._isEditable = false
//        uiView.isEnabled = self.selectable
//    }
//
//    func selectable(_ selectable: Bool) -> SelectableText {
//        return SelectableText(self.text, selectable: selectable)
//    }
//
//}
