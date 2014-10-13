/*
 * =BEGIN CLOSED LICENSE
 *
 *  Copyright(c) 2013 Andras Csizmadia.
 *  http://www.vpmedia.eu
 *
 *  For information about the licensing and copyright please
 *  contact Andras Csizmadia at andras@vpmedia.eu.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 * =END CLOSED LICENSE
 */
 
package
{ 
    import app.config.AppConfig;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.events.Event;
    
    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.contextView.ContextView;
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.LogLevel;
    import robotlegs.bender.framework.impl.Context;

    /*
    [SWF width="#"
    height="#"
    widthPercent="#"
    heightPercent="#"
    scriptRecursionLimit="#"
    scriptTimeLimit="#"
    frameRate="#"
    backgroundColor="#"
    pageTitle="<String>"]
    */
    [SWF(backgroundColor="0x000000", frameRate="30", width="800", height="600")]

    /**
     * ApplicationContext
     */
    public class Main extends MovieClip
    {
		public var context:IContext;
		
        //----------------------------------
        //  Constructor
        //----------------------------------

        /**
         * Constructor
         * @param parentStage Stage
         * @param parentRoot DisplayObject
         */
        public function Main(parentStage:Stage=null, parentRoot:DisplayObject=null)
        {
            trace(this, "created");

            var baseStage:Stage=parentStage ? parentStage : stage;
            var baseRoot:DisplayObject=parentRoot ? parentRoot : this;
			
			addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true);

            super(); 
        }

        //----------------------------------
        //  Bootstrap
        //----------------------------------

        /**
         * Startup the application
         */
        public function initialize(event:Event = null):void
        {
            trace(this, "initialize");
						
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			addEventListener(Event.REMOVED_FROM_STAGE, dispose, false, 0, true);

			context = new Context();
			context.install(MVCSBundle,SignalCommandMapExtension);
			context.logLevel = LogLevel.DEBUG; 
			context.configure(AppConfig,new ContextView(this));
            
        }

        //----------------------------------
        //  API
        //----------------------------------

        /**
         * Shutdown the application
         */
        public function dispose(event:Event = null):void
        {
            trace(this, "dispose");
			
			removeEventListener(Event.REMOVED_FROM_STAGE, dispose);			
        }

        // EOC

    }

    //EOP

}
