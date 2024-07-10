import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import Data from '../models/Data'

@Entry
@Component
struct phoneZone {
  currentphoneZoneIndex: number = 0;
  aboutToAppear(): void {
    let params:Data  = router.getParams() as Data
    this.currentphoneZoneIndex = params.id as number
  }
  
  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Column() {
          }.width('100%').height('100%').backgroundColor('#FAFAFA')

          Row() {
            Button() {
              Image($r("app.media.leftarrow")).margin({ left: 10 })
            }.width(50).height(20).backgroundColor('#FAFAFA')
            .onClick(() => {
              console.info(`Succeeded in clicking the 'Back' button.`)
              try {
                // 返回第一页
                router.back({url:'pages/home',params: {id:this.currentphoneZoneIndex} })
                console.info('Succeeded in returning to the home page.')
              } catch (err) {
                let code = (err as BusinessError).code;
                let message = (err as BusinessError).message;
                console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
              }
            })
          }.margin({ left: 25 }).width("100%").justifyContent(FlexAlign.Start).zIndex(10)

          Row() {
            Text("选择手机归属地").fontSize(20)
          }.width('100%').height('100%').justifyContent(FlexAlign.Center)
        }.width('100%').height(60)
      }
      .width("100%")
      .height(60)

      Column() {
        Button() {
          Row(){
              Text("中国")
              Text("+86")
          }
        }
        .margin({top:20})
        .backgroundColor("#A1A2A3")
        .width("100%")
        .height(50)
        .onClick(() => {
          this.currentphoneZoneIndex = 0
          console.info(`Succeeded in clicking the 'cn' button.`)
          try {
            // 返回第一页
            router.back({url:'pages/home',params: {id:this.currentphoneZoneIndex} })
            console.info('Succeeded in returning to the home page.')
          } catch (err) {
            let code = (err as BusinessError).code;
            let message = (err as BusinessError).message;
            console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })

        Button() {
          Row(){
            Text("霉国")
            Text("+1")
          }
        }
        .margin({top:20})
        .backgroundColor("#F1F2F3")
        .width("100%")
        .height(50)
        .onClick(() => {
          this.currentphoneZoneIndex = 1
          console.info(`Succeeded in clicking the 'us' button.`)
          try {
            // 返回第一页
            router.back({url:'pages/home',params: {id:this.currentphoneZoneIndex} })
            console.info('Succeeded in returning to the home page.')
          } catch (err) {
            let code = (err as BusinessError).code;
            let message = (err as BusinessError).message;
            console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })
        Button() {
          Row(){
            Text("小日本")
            Text("+81")
          }
        }
        .margin({top:20})
        .backgroundColor("#A1A2A3")
        .width("100%")
        .height(50)
        .onClick(() => {
          this.currentphoneZoneIndex = 2
          console.info(`Succeeded in clicking the 'cn' button.`)
          try {
            // 返回第一页
            router.back({url:'pages/home',params: {id:this.currentphoneZoneIndex} })
            console.info('Succeeded in returning to the home page.')
          } catch (err) {
            let code = (err as BusinessError).code;
            let message = (err as BusinessError).message;
            console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })
      }
    }
  }
}
