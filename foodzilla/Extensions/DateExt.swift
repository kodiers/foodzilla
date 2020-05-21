//
//  DateExt.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 22.05.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import Foundation

extension Date {
    func isLessThan(_ date: Date) -> Bool {
        return self.timeIntervalSince(date) < date.timeIntervalSinceNow
    }
}
