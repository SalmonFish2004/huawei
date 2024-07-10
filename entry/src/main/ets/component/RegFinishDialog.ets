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

  onPageShow(){
    //this.textTimerController.start()
    setTimeout(() => {
      try {
        this.controller.close()
        if(this.confirm){
        this.confirm()
        }
      } catch (error) {
        console.error(`closeDialog error `);
      };
    }, 2000);
  }

  build() {
    Column(){
      Text(`欢迎回来！`)
        .fontSize(20)
        .margin({ top: 30 })
      Text(`用户${this.username}登录成功`)
        .fontSize(20)
        .margin({ top: 10 })
      Blank()
      // TextTimer({ isCountDown: true, count: 3000, controller: this.textTimerController })
      //   .margin({bottom:30})
      //   .format(this.format)
      //   .onTimer(()=>{
      //     this.controller.close()
       //    if(this.confirm){
      //       this.confirm()
      //     }
      //   })

    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

