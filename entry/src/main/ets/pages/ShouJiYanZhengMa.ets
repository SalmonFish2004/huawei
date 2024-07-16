import CodeInputView from '../component/CodeinputView'
import { router, display } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { phoneZones } from '../models/phoneZones';
import UserPhoneNumData from '../models/UserPhoneNumData';
import RegFinishDialog from '../component/RegFinishDialog'
import { User } from '../models/User';

@Entry
@Component
struct ShouJiYanZhengMa {
  currentphoneZoneIndex: number = 0;
  UserPhoneNumData = "";
  user = new User();

  controller2: CustomDialogController = new CustomDialogController({
    builder: RegFinishDialog({
      username: this.UserPhoneNumData,
      confirm: () => {
        router.pushUrl({
          url: "pages/NewsPage",
          params: this.user
        })
      }
    }),
    cancel: this.exitApp,
    autoCancel: true,
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    height: 200,
  })

  aboutToAppear(): void {
    let params:UserPhoneNumData  = router.getParams() as UserPhoneNumData
    this.currentphoneZoneIndex = params.user.currentphoneZoneIndex as number
    this.UserPhoneNumData = params.user.Phone as string
    this.user = params.user as User
  }

  exitApp() {
  }

  @State codeResult: string = '';

  handleCodeInput(value: string) {
    this.codeResult = value;
    console.log(`验证码输入完成: ${value}`);
    this.controller2.open()
  }

  build() {
    Column() {
      Row() {
        Button() {
          Image($r("app.media.leftarrow")).margin({ left: 10 })
            .width(50)
            .height(30)
        }
        .margin({ left: 10 }).constraintSize({minWidth:50,minHeight:50}).width("15%").height("40%").backgroundColor(Color.White).onClick(() => {
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
      }
      .width("100%")
      .height("100%")
      .layoutWeight(2)
      Column(){
        Row() {Text("输入验证码").fontSize(25).fontWeight(FontWeight.Bold)}
        .width("100%")
        .justifyContent(FlexAlign.Start)
        Row() {Text(`验证码已发送至 ${phoneZones[this.currentphoneZoneIndex]} ${this.UserPhoneNumData}`).fontSize(15)}
        .justifyContent(FlexAlign.Start).width("100%").margin({top:10})
        Row() {
          CodeInputView({
            viewSize: 4,
            codeResult: this.codeResult,
            inputResultCallback: (value: string) => {
              this.handleCodeInput(value);
            },
          })
        }
      }
      .width("80%")
      .height("100%")
      .layoutWeight(5)


      Row() {
        Blank()
      }
      .layoutWeight(3)

    }
  }
}