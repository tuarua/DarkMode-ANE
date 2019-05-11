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

#import <Foundation/Foundation.h>
#import "FreMacros.h"
#import "DarkModeANE_oc.h"
#import <DarkModeANE/DarkModeANE-Swift.h>

SWIFT_DECL(TRDM) // use unique prefix throughout to prevent clashes with other ANEs

CONTEXT_INIT(TRDM) {
    SWIFT_INITS(TRDM)
    
    /**************************************************************************/
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRDM, getIsEnabled)
        ,MAP_FUNCTION(TRDM, setIsEnabled)
        ,MAP_FUNCTION(TRDM, isAvailable)
    };
    /**************************************************************************/
    /**************************************************************************/
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRDM) {
    //any clean up code here
}
EXTENSION_INIT(TRDM)
EXTENSION_FIN(TRDM)
