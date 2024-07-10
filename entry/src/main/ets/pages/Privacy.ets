import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Privacy {
  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Column() {
          }.width('100%').height('100%').backgroundColor('#FAFAFA')

          Row() {
            Button() {
              Image($r("app.media.leftarrow")).margin({ left: 10 })
            }.width(50).height(20).backgroundColor('#FAFAFA').onClick(() => {
              console.info(`Succeeded in clicking the 'Back' button.`)
              try {
                // 返回第一页
                router.back()
                console.info('Succeeded in returning to the home page.')
              } catch (err) {
                let code = (err as BusinessError).code;
                let message = (err as BusinessError).message;
                console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
              }
            })
          }.margin({ left: 25 }).width("100%").justifyContent(FlexAlign.Start).zIndex(10)

          Row() {
            Text("建桥论坛隐私条款").fontSize(20)
          }.width('100%').height('100%').justifyContent(FlexAlign.Center)
        }.width('100%').height(60)
      }
      .width("100%")
      .height(60)

      Row() {
       Text("这是建桥论坛隐私条款")
         .fontSize(15)
         .textAlign(TextAlign.Start)
      }
    }
  }
}
