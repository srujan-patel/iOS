//
//  UIResponderExtension.swift
//  DuckDuckGo
//
//  Copyright © 2024 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

extension UIResponder {

    /// Attempts to open a URL using the UIApplication instance in the responder chain.
    /// This is required as the CredentialProvider extension context cannot directly launch the host app.
    /// - Returns: True if the URL was opened successfully, false otherwise.
    @discardableResult
    func openUrl(_ url: URL?) -> Bool {
        guard let url = url else { return false }

        var responder: UIResponder? = self
        while let r = responder {
            if let application = r as? UIApplication {
                application.open(url, options: [:], completionHandler: nil)
                return true
            }
            responder = r.next
        }

        return false
    }
}
