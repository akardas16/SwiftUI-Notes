AnimatedImage(url: URL(string: "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI")).resizable().frame(width: 300, height: 200).cornerRadius(8).scaledToFit().cornerRadius(16).scaleEffect(1 + currentAmount ).gesture(
                    MagnificationGesture().onChanged{ value in
                        currentAmount = value - 1
                        print("onchanged \(currentAmount + lastAmount)")
                    }.onEnded{value in
                       // lastAmount += currentAmount
                        withAnimation(.spring()) {
                            currentAmount = 0
                        }
                        
                        
                    }
                )
                
                
                //Rotation Gesture
    AnimatedImage(url: URL(string: "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI")).resizable().frame(width: 300, height: 200).cornerRadius(8).scaledToFit().cornerRadius(16).rotationEffect(angle).gesture(
                    RotationGesture().onChanged{ value in
                        print("\(value)")
                        angle = value
                    }.onEnded{value in
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.33)) {
                            angle = Angle(degrees: 0)
                        }
                      
                    }
                )