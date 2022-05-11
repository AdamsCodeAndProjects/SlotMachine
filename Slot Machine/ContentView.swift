//
//  ContentView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct ContentView: View {
    
    let symbols = ["bell", "cherry", "coin", "grape", "seven", "strawberry"]
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    // MARK: FUNCTIONS
    
    // Spin the reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        //  Same as above but short code
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    // Check the winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] {
            // Player wins
            playerWins()
            // New high score
            if coins > highscore {
                newHighScore()
            }
        } else {
            // Player loses
            playerLoses()
            
        }
    }
    
    func playerWins() {
        coins += betAmount * 12
    }
    
    func newHighScore() {
        highscore = coins
        // Saves the high score until replaced
        UserDefaults.standard.set(highscore, forKey: "HighScore")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    // Game is over
    func isGameOver() {
        if coins <= 0 {
            // Show modal window
            showingModal = true
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
    }
    
    
    var body: some View {
        
        ZStack {
            // -----------------------Background-------------------------------
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // ------------------------Interface--------------------------------
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
                
                // --------------------Score------------------------------
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle() // extension with added styling
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle() // Another extension
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highscore)")
                            .scoreNumberStyle() // Another extension
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle() // extension with added styling
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                VStack(alignment: .center, spacing: 0) {
                    
                    // MARK: REELS
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50) // moves the image down 50 points
                            .animation(Animation.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                            })
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(Animation.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingSymbol)
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(Animation.easeOut(duration: Double.random(in: 0.9...1.2)), value: animatingSymbol)
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: SPIN BUTTON
                    Button(action: {
                        // Set the default state
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        // Spin the reels
                        self.spinReels()
                        
                        // trigger the animation
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        self.checkWinning()
                        
                        // Game is over
                        self.isGameOver()
                    }) {
                        Image("spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                
                Spacer()
                
                HStack {
                    // Bet
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            self.activateBet20()
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        
                        .modifier(BetCapsuleModifier())
                        
                        Image("casino-chips")
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 10) {
                        Image("casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        Button(action: {
                            self.activateBet10()
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        
                        .modifier(BetCapsuleModifier())
                        
                        
                    }
                }
            }
            //-----------------------Top Buttons--------------------------------
            .overlay(
                Button(action: {
                    self.resetGame()
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .font(.title)
                    .accentColor(Color.white), alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    self.showingInfoView = true
                }) {
                    Image(systemName: "info.circle")
                }
                    .font(.title)
                    .accentColor(Color.white), alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)  // Blurs game once our of money
            
            // MARK: POPUP
            if $showingModal.wrappedValue {
                ZStack {
                    // Darkens the background
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    
                    // MODAL
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        //  Message
                        VStack(alignment: .center, spacing: 16) {
                            Image("seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("You lost all of your coins!  Not to worry.  \nPlay again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModal = false
                                self.animatingModal = false
                                self.activateBet10()
                                self.coins = 100
                            }) {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: animatingModal)
                    .onAppear(perform: {
                        self.animatingModal = true
                    })
                }
            }
        }
        //  Presents new sheet to pop up over View when showingInfoView is true
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
