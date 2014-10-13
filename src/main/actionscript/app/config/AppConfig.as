/*
 * =BEGIN CLOSED LICENSE
 *
 *  Copyright(c) 2014 Andras Csizmadia.
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

package app.config
{
    import app.service.AppServiceCommand;
    import app.model.AppModel;
    import app.service.AppService;
    import app.view.AppMediator;
    import app.view.AppView;
    
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.system.Security;
    
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.contextView.ContextView;
    import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.ILogger;
    
    /**
     * TBD
     * @author Andras Csizmadia
     */
    public class AppConfig implements IConfig
    {
        
        [Inject]
        public var context:IContext;
        
        [Inject]
        public var contextView:ContextView;
        
        [Inject]
        public var dispatcher:IEventDispatcher;
        
        [Inject]
        public var injector:Injector;
        
        [Inject]
        public var mediatorMap:IMediatorMap;
        
        [Inject]
        public var eventCommandMap:IEventCommandMap;
        
        [Inject]
        public var signalCommandMap:ISignalCommandMap;
        
        [Inject]
        public var logger:ILogger;
        
        public function AppConfig()
        {
        }
        
        public function configure():void
        {
            initCore();
            initBehaviours();
            initModels();
            initServices();
            initActions();
            context.afterInitializing(init);
        }
        
        private function init():void
        {
            logger.debug("init");
            
			dispatcher.dispatchEvent(new Event(Event.INIT));
            
            contextView.view.addChild(new AppView());
        }
        
        private function initCore():void
        {
            try
            {
                Security.allowDomain("*");
            }
            catch (error:Error)
            {
                trace(this, error);
            }
        }
        
        private function initActions():void
        {
            eventCommandMap.map(Event.INIT).toCommand(AppServiceCommand).once();
        }
        
        private function initBehaviours():void
        {
            mediatorMap.map(AppView).toMediator(AppMediator);
        }
        
        private function initModels():void
        {
            injector.map(AppModel).toSingleton(AppModel);
        }
        
        private function initServices():void
        {
            injector.map(AppService).toSingleton(AppService);
        }
    }
}
