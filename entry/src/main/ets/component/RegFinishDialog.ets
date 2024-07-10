
import Constants from '../utils/Constants'

@CustomDialog
export default struct RegFinishDialog {
  controller: CustomDialogController = new CustomDialogController({
    builder: RegFinishDialog()
  })
  cancel?: () => void
  confirm?: () => void
  userName: String = ""

  build() {
    Column() {
      Text(`用户 ${this.userName}注册成功`)
        .margin({ top: 20 })
        .fontSize(20)
      Blank()
      Row(){
        Button("取消")
          .margin({ bottom: 20 })
          .onClick(() => {
            this.controller.close()
            if (this.cancel) {
              this.cancel()
            }
          })
        Button("确定")
          .margin({ bottom: 20 })
          .onClick(() => {
            this.controller.close()
            if (this.confirm) {
              this.confirm()
            }
          })
      }

    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}