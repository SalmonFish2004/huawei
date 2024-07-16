import { BUNDLE_NAME } from 'BuildProfile'
import Constants from '../utils/Constants'
//import { FunctionalButton } from '@hms.core.atomicserviceComponent.atomicserviceUi'



@CustomDialog
@Component
export default struct RegFinishDialog{
  controller: CustomDialogController = new CustomDialogController({
    builder: RegFinishDialog()
  })

  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'ss'

  cancel?: () => void
  confirm?: () => void
  username: string = ""

  aboutToAppear(){
    setTimeout(() => {
      this.controller.close()
      if(this.confirm){
        this.confirm()
      }
    }, 1500)
  }

  build() {
    Column() {
      Text(`欢迎回来！`)
        .fontSize(30)
        .margin({ top: 20 })
      Text(`用户${this.username}登录成功`)
        .fontSize(20)
        .margin({ top: 30 })
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

