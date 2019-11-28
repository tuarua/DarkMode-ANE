/* Copyright 2019 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/

import Foundation
import Cocoa
import FreSwift

public class SwiftController: NSObject {
    public static var TAG = "SwiftController"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    func getIsEnabled(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return (UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark").toFREObject()
    }
    
    func setIsEnabled(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let value = Bool(argv[0])
            else {
                return FreArgError().getError()
        }
        
        if value {
            if #available(OSX 10.14, *) {
                NSApp.mainWindow?.appearance = NSAppearance(named: .darkAqua)
            }
        } else {
            NSApp.mainWindow?.appearance = NSAppearance(named: .aqua)
        }
        
        return nil
    }
    
    func isAvailable(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        if #available(OSX 10.14, *) {
            return true.toFREObject()
        }
        return false.toFREObject()
    }
}
