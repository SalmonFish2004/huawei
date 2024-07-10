import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';
import { display } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { User } from '../models/User';
import { userGroup } from '../models/userGroup';
import { phoneZones } from '../models/phoneZones';
import { departments } from '../models/departments';

function ifLoginButton(a:number , b:number,c:boolean){
  if (a == 11 && b >= 6) {
    return c = true
  } else {
    return c = false
  }
}


@Entry
@Component
struct home {

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      confirm: () => {
        this.onAccept()
        this.user.isPrivacy = true
        this.isPrivacySelected = true
      },
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
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 10,
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  @State currentDepartmentIndex: number = 0;
  @State currentphoneZoneIndex: number = 0;
  @State currentuserGroupIndex: number = 0;
  @State defaultPHFont: number = 15;
  @State smallPHFont: number = 25;
  user = new User()
  @State PH1size: number = this.defaultPHFont;
  @State PH2size: number = this.defaultPHFont;
  @State loginButtonState: boolean = false;
  @State passwdInputState: Visibility = Visibility.Visible;
  @State phoneInputState: Visibility = Visibility.None;
  @State phoneinputText: string = '';
  @State pinputText: string = '';
  @State ClearPhoneInputstate: Visibility = Visibility.None;
  @State ClearPInputstate: Visibility = Visibility.None;
  @State isPrivacySelected : boolean  = this.user.isPrivacy;
  controller: TextInputController = new TextInputController();



  //control

  build() {

    Column() {

      Row() {
        Text("Hi  欢迎回来！")
          .fontSize(30)
      }
      .width("80%")
      .justifyContent(FlexAlign.Start)
      .height("100%")
      .layoutWeight(4)

      Row() {
        Row() {
          Text(`${userGroup[this.currentuserGroupIndex]}`)
            .fontSize(18)
          Text("🔽")
            .fontSize(20)
        }
        .bindMenu(this.menuBuilder, { placement: Placement.Bottom })
        .width(95)
        .borderRadius(8)
        .height(40)
        .padding({ right: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width("80%")
      .height("100%")
      .layoutWeight(1)

      Column() {
        Column() {
          Row() {
            RelativeContainer() {
              Button() {
                Row() {
                  Text(`${phoneZones[this.currentphoneZoneIndex]} `)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Row() {
                    Text("ˇ")
                      .fontSize(50)
                  }
                  .height(25)
                }
              }
              .height("100%")
              .width(75)
              .id("phoneZone")
              .alignRules({
                top: { anchor: "__container__", align: VerticalAlign.Top },
                left: { anchor: "__container__", align: HorizontalAlign.Start },
              })
              .backgroundColor(Color.White)
              // 跳转按钮绑定onClick事件，点击时跳转到归属地页
              .onClick(() => {
                console.info(`Succeeded in clicking the 'phoneZone' button.`)
                // 跳转到归属地页
                router.pushUrl({ url: 'pages/phoneZone', params: this.currentphoneZoneIndex }).then(() => {
                  console.info('Succeeded in jumping to the phoneZone page.')
                }).catch((err: BusinessError) => {
                  console.error(`Failed to jump to the phoneZone page. Code is ${err.code}, message is ${err.message}`)
                })
              })

              TextInput({ placeholder: "请输入手机号", text: $$this.phoneinputText, controller: this.controller })
                .inputFilter('[0-9]', (error) => {
                  promptAction.showToast({ message: "不是数字类型" })
                })
                .tabIndex(1)
                .padding({ left: 5 })
                .maxLength(11)
                .type(InputType.USER_NAME)
                .fontSize(25)
                .backgroundColor(Color.White)
                .onChange((value) => {
                  this.user.userName = this.phoneinputText;
                  if (this.phoneinputText == '') {
                    this.ClearPhoneInputstate = Visibility.None
                  } else {
                    this.ClearPhoneInputstate = Visibility.Visible
                  }
                  this.loginButtonState = ifLoginButton(this.user.userName.length,this.user.passWord.length,this.loginButtonState)
                })
                .onEditChange((isEditing: boolean)=>{
                  if(isEditing){
                    this.PH1size = this.smallPHFont
                  }else{
                    this.PH1size = this.defaultPHFont
                  }
                })
                .placeholderFont({ size: this.PH1size })
                .enterKeyType(EnterKeyType.Next)
                .height("100%")
                .alignRules({
                  top: { anchor: "__container__", align: VerticalAlign.Top },
                  left: { anchor: "phoneZone", align: HorizontalAlign.End },
                  right: { anchor: "__container__", align: HorizontalAlign.End },
                })
              Row() {
                Button() {
                  Text("❌️")
                }
                .onClick(() => {
                  this.user.userName = '';
                  this.phoneinputText = '';
                })
                .backgroundColor(Color.White)
                .fontColor(Color.Black)
                .height("68%")
                .width("68%")
              }
              .visibility(this.ClearPhoneInputstate)
              .justifyContent(FlexAlign.End)
              .width("15%")
              .height("100%")
              .alignRules({
                right: { anchor: "__container__", align: HorizontalAlign.End },
              })
            }
            .width("100%")
            .height("100%")
          }
          .width("80%")
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)
          .height(48.5)

          Row() {
          }.width("80%").height(1.5).backgroundColor("#AAAAAA")
        }
        .width("100%")
        .height(50)

        Row() {
          Text("未注册的手机号验证后自动创建建桥论坛账号")
            .fontSize(13)
            .margin({ top: 10 })
            .fontColor("#AAAAAA")
        }
        .width("80%")
        .padding({ left: 10 })
        .height(50)
        .alignItems(VerticalAlign.Top)
        .visibility(this.phoneInputState)

        Column() {
          RelativeContainer() {
            TextInput({ placeholder: "请输入密码", text: $$this.pinputText ,controller: this.controller})
              .constraintSize({ minHeight: 50 })
              .tabIndex(1)
              .fontSize(18)
              .onChange((value: string) => {
                this.user.passWord = this.pinputText;
                if (this.pinputText == '') {
                  this.ClearPInputstate = Visibility.None
                } else {
                  this.ClearPInputstate = Visibility.Visible
                }
                this.loginButtonState = ifLoginButton(this.user.userName.length,this.user.passWord.length,this.loginButtonState)
                console.debug(`isEditing2 ${this.loginButtonState}`)
              })
              .onEditChange((isEditing: boolean)=>{
                if(isEditing){
                  this.PH2size = this.smallPHFont
                }else{
                  this.PH2size = this.defaultPHFont
                }
              })
              .enterKeyType(EnterKeyType.Done)
              .placeholderFont({ size: this.PH2size })
              .backgroundColor(Color.White)
              .type(InputType.NEW_PASSWORD)
              .padding({ left: 5 })
            Row() {
              Button() {
                Text("❌️")
              }
              .onClick(() => {
                this.user.passWord = '';
                this.pinputText = '';
              })
              .backgroundColor(Color.White)
              .fontColor(Color.Black)
              .width("68%")
              .height("68%")
            }
            .visibility(this.ClearPInputstate)
            .offset({
              x: -30
            })
            .width("15%")
            .height("100%")
            .alignRules({
              top: { anchor: "__container__", align: VerticalAlign.Top },
              right: { anchor: "__container__", align: HorizontalAlign.End },
            })
          }
          .width("82%")
          .height(48.5)

          Row() {
          }.width("80%").height(1.5).backgroundColor("#AAAAAA")
        }
        .visibility(this.passwdInputState)
        .width("100%")
        .height(50)

        Row() {
          Checkbox()
            .select(this.isPrivacySelected)
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .onChange((isCheck: boolean) => {
              this.user.isPrivacy = isCheck
            })
          Text("我已阅读并同意")
            .fontSize(14)
          Button() {
            Text("隐私条款")
              .fontSize(14)
              .decoration({ type: TextDecorationType.Underline, color: Color.Blue })
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

          Text("与")
            .fontSize(14)
          Button() {
            Text("用户协议")
              .fontSize(14)
              .decoration({ type: TextDecorationType.Underline, color: Color.Blue })
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
        .width("80%")
        .height(70)
      }
      .width("100%")
      .height("100%")
      .layoutWeight(4)
      .constraintSize({ minHeight: 170 })
      .justifyContent(FlexAlign.Center)


      // Row() {
      //   Toggle({ type: ToggleType.Checkbox, isOn: false })
      //     .width(25)
      //     .height(25)
      //     .margin({ right: 8 })
      //   Text("保持登录状态")
      // }
      // .margin({ top: 20 })
      Row() {
        Button("登录")
          .width("80%")
          .enabled(this.loginButtonState)
          .onClick(() => {
            if(!this.user.isPrivacy){
              if (this.dialogController != null) {
                this.dialogController.open()
              }
            }else {
              console.debug(`${JSON.stringify(this.user)}`)
            }
          })
      }
      .height("100%")
      .layoutWeight(1)
      .visibility(this.passwdInputState)

      Row() {
        Button("获取短信验证码")
          .width("80%")
          .enabled(this.loginButtonState)
          .onClick(() => {
            console.debug(`isEditing2 ${this.loginButtonState}`)
            if(!this.user.isPrivacy){
              if (this.dialogController != null) {
                this.dialogController.open()
              }
            }else {
              console.debug(`${JSON.stringify(this.user)}`)
            }
          })
      }
      .height("100%")
      .layoutWeight(1)
      .visibility(this.phoneInputState)

      Row() {
        Row() {
          Button() {
            Text("验证码登录")
              .fontSize(15)
              .fontWeight("bold")
              .fontColor(Color.Gray)
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            this.phoneInputState = Visibility.Visible
            this.passwdInputState = Visibility.None
            this.pinputText = ""
            if (this.user.userName.length == 11) {
              this.loginButtonState = true
            } else {
              this.loginButtonState = false
            }
          })
        }
        .width("50%")
        .justifyContent(FlexAlign.Start)
        .padding({ left: "10%" })
        .visibility(this.passwdInputState)

        Row() {
          Button() {
            Text("密码登录")
              .fontSize(15)
              .fontWeight("bold")
              .fontColor(Color.Gray)
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            this.phoneInputState = Visibility.None
            this.passwdInputState = Visibility.Visible
            this.loginButtonState = ifLoginButton(this.user.userName.length,this.user.passWord.length,this.loginButtonState)
          })
        }
        .width("50%")
        .justifyContent(FlexAlign.Start)
        .padding({ left: "10%" })
        .visibility(this.phoneInputState)

        Row() {
          Text("帮助")
            .fontSize(15)
            .fontWeight("bold")
            .fontColor(Color.Gray)
        }
        .width("50%")
        .justifyContent(FlexAlign.End)
        .padding({ right: "10%" })
      }
      .margin({ top: 20 })
      .height("100%")
      .layoutWeight(2)
    }
    .id("root")
    .height('100%')
    .width('100%')
    .onClick(()=>{
      this.controller.stopEditing()
    })
    .focusable(true)
  }

  @Builder
  menuBuilder() {
    List() {
      ForEach(userGroup, (item: string, index: number) => {
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
          this.currentuserGroupIndex = index
        })
      }, (item: string) => item)
    }
    .divider({ strokeWidth: 2 })
    .width(140)
    .height(userGroup.length * 32 - 2)
  }
}

@CustomDialog
@Component
struct CustomDialogExample {
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

      Button('confirm')
        .onClick(() => {
          if (this.controller != undefined) {
            this.controller.close()
            this.confirm()
          }
        })
        .margin({bottom:30})
        .width("100%")

    }.width("80%")
  }
}
