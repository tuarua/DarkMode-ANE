/*
 * Copyright 2019 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */
package com.tuarua {

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;

public class DarkMode extends EventDispatcher {
    private static const name:String = "DarkModeANE";
    private static var _ctx:ExtensionContext;
    private static const isMac:Boolean = Capabilities.version.substr(0, 3).toLowerCase() == "mac";

    public function DarkMode() {
    }

    private static function get ctx():ExtensionContext {
        if (_ctx == null) {
            try {
                _ctx = ExtensionContext.createExtensionContext("com.tuarua." + name, null);
                _ctx.addEventListener(StatusEvent.STATUS, gotEvent);
            } catch (e:Error) {
                trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
            }
        }
        return _ctx;
    }

    private static function gotEvent(event:StatusEvent):void {
        if (event.level === "TRACE") {
            trace(event.code);
        }
    }

    public static function set isEnabled(value:Boolean):void {
        if (!isMac) return;
        ctx.call("setIsEnabled", value);
    }

    public static function get isEnabled():Boolean {
        if (!isMac) return false;
        return ctx.call("getIsEnabled") as Boolean;
    }

    public static function get isAvailable():Boolean {
        if (!isMac) return false;
        return ctx.call("isAvailable") as Boolean;
    }

    public static function dispose():void {
        if (_ctx == null) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        _ctx.dispose();
        _ctx = null;
    }

}
}
