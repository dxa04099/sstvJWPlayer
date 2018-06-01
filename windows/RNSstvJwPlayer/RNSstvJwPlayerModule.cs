using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Sstv.Jw.Player.RNSstvJwPlayer
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNSstvJwPlayerModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNSstvJwPlayerModule"/>.
        /// </summary>
        internal RNSstvJwPlayerModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNSstvJwPlayer";
            }
        }
    }
}
