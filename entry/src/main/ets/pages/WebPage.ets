import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebPage {
  url: string = (router.getParams() as Record<string,string>).url
  webController: webview.WebviewController = new webview.WebviewController

  build() {
    Column(){
      Web({ src: this.url, controller: this.webController })
        .onControllerAttached(() => {
          this.webController.setCustomUserAgent("mozilla/5.0 (linux; android 12; harmonyos; jad-al00; hmscore 6.8.0.332 applewebkit/537.36 (khtml, like gecko) chrome/99.0.4844.88 huaweibrowser/13.0.0.310 mobile safari/537.36")
        })
        .width("100%")
        .height("100%")
    }
    .height('100%')
    .width('100%')
  }
}