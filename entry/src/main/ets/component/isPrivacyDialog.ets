import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@CustomDialog
@Component
export default struct isPrivacyDialog {
  controller?: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在所有controller的后面
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('请阅读并同意以下条款').fontSize(18).fontWeight(FontWeight.Bolder).margin({ top: 30, bottom: 10 })
      Row() {
        Row() {
          Button() {
            Text("《隐私条款》")
              .fontSize(18)
          }
          .onClick(() => {
            console.info(`Succeeded in clicking the 'Privacy' button.`)
            // 跳转到隐私条款页
            router.pushUrl({ url: 'pages/Privacy' }).then(() => {
              console.info('Succeeded in jumping to the Privacy page.')

            }).catch((err: BusinessError) => {
              console.error(`Failed to jump to the Privacy page. Code is ${err.code}, message is ${err.message}`)
            })
          })
          .backgroundColor(Color.White)
          .fontColor(Color.Blue)

          Row() {
          }.width("10%")

          Button() {
            Text("《用户协议》")
              .fontSize(18)
          }
          .onClick(() => {
            console.info(`Succeeded in clicking the 'UserLience' button.`)
            // 跳转到用户协议页
            router.pushUrl({ url: 'pages/UserLience' }).then(() => {
              console.info('Succeeded in jumping to the UserLience page.')

            }).catch((err: BusinessError) => {
              console.error(`Failed to jump to the UserLience page. Code is ${err.code}, message is ${err.message}`)
            })
          })
          .backgroundColor(Color.White)
          .fontColor(Color.Blue)
        }
        .width("100%")
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .height(70)
      }
      .width("100%")

      Button('同意并继续')
        .onClick(() => {
          if (this.controller != undefined) {
            this.controller.close()
            this.confirm()
          }
        })
        .margin({ bottom: 30 })
        .width("100%")

    }.width("80%")
  }
}
