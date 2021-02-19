//
//  ResultView.swift
//  TextRecognizer
//
//  Created by Neringa Geigalaite on 2021-02-19.
//  Copyright © 2021 Neringa Geigalaite. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    let resultItems: [String]
    
    var body: some View {
        List(resultItems, id: \.self) { string in
            Text(string)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultItems: ["a", "b"])
    }
}
