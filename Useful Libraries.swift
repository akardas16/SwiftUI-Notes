//USEFUL LİBRARİES

//PhoneNumber Textfield
 iPhoneNumberField("(000) 000-0000", text: $text, isEditing: $isEditing)
                      .flagHidden(false)
                      .flagSelectable(true)
                      .prefixHidden(false)
                      .autofillPrefix(true)
                      .defaultRegion("TR")
                      .font(UIFont(size: 24, weight: .light, design: .monospaced))
                      .maximumDigits(10)
                      .foregroundColor(Color.black)
                
                      .clearButtonMode(.never)
                      .onClear { _ in isEditing.toggle() }
                      .accentColor(Color.orange)
                      .padding(8)
                      .background(Color.gray.opacity(0.3))
                      .cornerRadius(16)
                     // .shadow(color: isEditing ? .gray : .white, radius: 10)
                      .padding(36)
                      
//https://github.com/MojtabaHs/iPhoneNumberField