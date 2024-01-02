//
//  ContentView.swift
//  PasswordGenerator
//
//  Created by Karl Kowalski on 1/1/24.
//

import SwiftUI
import CryptoSwift

struct ContentView: View {
    
    @State var passwordText: String = ""
    @State var saltText: String = ""
    @State var iterationsInt: Int?
    @State var hexadecimalString: String = "waiting for generate"
    @State var base64String: String = "waiting for generate"
    

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("PasswordGenerator")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            Group {
                TextField("Password", text: $passwordText)
                TextField("Salt", text: $saltText)
                TextField("Iterations", value: $iterationsInt, format:.number)
            }
            .padding(.all, 5)
            .font(Font.system(size: 24))
            //
            Button(action: {
                generatePassword()
            }, label: {
                Text("Generate")
                    .font(Font.system(size: 18))
            })
            .padding()
            Group {
                HStack {
                    Text("Hexadecimal:")
                    Spacer()
                    Text(hexadecimalString)
                }
                HStack {
                    Text("Base64:")
                    Spacer()
                    Text(base64String)
                }
            }
            .font(Font.system(size: 24))
            .disabled(true)
        }
        .padding()
    }
    
    func generatePassword() {
        print("Starting")
        let password: Array<UInt8> = Array(passwordText.utf8)
        let salt: Array<UInt8> = Array(saltText.utf8)
        let iterations = iterationsInt ?? 0
        if iterations > 0 {
            print("Iterations: \(iterations)")
            do {
                let start = Date.now.timeIntervalSince1970
                print("generating key")
                let key = try PKCS5.PBKDF2(password: password, salt: salt, iterations: iterations, keyLength: 32, variant: .sha2(.sha256)).calculate()
                // key is Array<UInt8>
                // convert to hexadecimal String
                hexadecimalString = key.toHexString()
                base64String = key.toBase64()
                let end = Date.now.timeIntervalSince1970
                let delta = end - start
                print("Duration: \(delta) seconds")
            } catch {
                print("Error computing PBKDF2: \(error.localizedDescription)")
            }
        } else {
            print("ERROR: iterations from iterationsInt = 0")
        }
    }
}

#Preview {
    ContentView()
}
