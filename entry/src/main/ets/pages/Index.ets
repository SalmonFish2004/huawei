import RegFinishDialog from '../component/RegFinishDialog';
import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { User } from '../models/User';
import { userGroup } from '../models/userGroup';
import { phoneZones } from '../models/phoneZones';
import { departments } from  '../models/departments';

@Entry
@Component
struct home {
  @State message: string = 'Hello';
  @State currentDepartmentIndex: number = 0
  @State user:User = new User()

  controller: CustomDialogController = new CustomDialogController({
    builder: RegFinishDialog({
      userName: this.user.userName,
      confirm: () => {
        router.pushUrl({
          url: "pages/",
          params: this.user
        })
      },
    }),
    height: 200,
    autoCancel: false
  })

  build() {
    Column() {
      Row({ space: 20 }) {
        Image($r("app.media.LOGO"))
          .width(40)
          .height(40)
        Text("建桥校友论坛")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .margin({ top: 50, bottom: 20 })

      Image($r("app.media.BG"))
        .width("100%")
        .height(150)//.backgroundColor(Color.Green)
        .objectFit(ImageFit.Cover)

      Row() {
        Text("用户名")
          .fontSize(20)
        TextInput({ placeholder: "请输入用户名" })
          .onChange((value: string) => {
            this.user.userName = value
          })
          .borderRadius(8)
          .width(200)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 30, left: 20, right: 20 })
      .padding({ left: 40, right: 40 })

      Row() {
        Text("密码")
          .fontSize(20)
        TextInput({ placeholder: "请输入密码" })
          .onChange((value: string) => {
            this.user.passWord = value
          })
          .borderRadius(8)
          .type(InputType.NEW_PASSWORD)
          .width(200)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 50, right: 40 })
      .margin({ top: 20, left: 20, right: 20 })

      Row() {
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .width(25)
          .height(25)
          .margin({ right: 8 })
        Text("保持登录状态")
      }
      .margin({ top: 20 })

      Row() {
        Text(`${departments[this.currentDepartmentIndex]}`)
          .fontSize(18)
        Text("🔽")
          .fontSize(20)
      }
      .bindMenu(this.menuBuilder, { placement: Placement.Bottom })
      .width("50%")
      .borderRadius(8)
      .height(40)
      .margin({ top: 30 })
      .padding({ left: 12, right: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(0xF1F2F3)

      Blank()
      Button("登录")
        .width("80%")
        .onClick(() => {
          console.debug(`${JSON.stringify(this.user)}`)
        })

      Row() {
        Checkbox()
          .shape(CheckBoxShape.ROUNDED_SQUARE)
          .onChange((isCheck: boolean) => {
            this.user.isPrivacy = isCheck
          })
        Text("我接受隐私条款与用户协议")
      }

      .margin(50)
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  menuBuilder() {
    List() {
      ForEach(departments, (item: string, index: number) => {
        ListItem() {
          Row() {
            Text(item)
              .fontSize(18)
          }
          .justifyContent(FlexAlign.Center)
          .width("100%")
          .height("100%")
        }
        .height(30)
        .onClick(() => {
          this.currentDepartmentIndex = index
        })
      }, (item: string) => item)
    }
    .divider({ strokeWidth: 2 })
    .width(140)
    .height(departments.length * 32 - 2)
  }
}