import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';
import { display } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { User } from '../models/User';
import { userGroup } from '../models/userGroup';
import { phoneZones } from '../models/phoneZones';
import { departments } from '../models/departments';

@Entry
@Component
struct home {
  @State message: string = 'Hello';
  @State currentDepartmentIndex: number = 0;
  @State currentphoneZoneIndex: number = 0;
  @State currentuserGroupIndex: number = 0;
  @State defaultPHFont: number = 15;
  @State smallPHFont: number = 25;
  user = new User()
  @State PH1size: number = this.defaultPHFont;
  @State PH2size: number = this.defaultPHFont;
  @State buttonColor: number = 0xF1F2F3;
  @State loginButtonState: boolean = false;
  @State passwdInputState: Visibility = Visibility.Visible;
  @State phoneInputState: Visibility = Visibility.None;
  @State phoneinputText: string = '';
  @State pinputText: string = '';
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
                top:{anchor:"__container__",align: VerticalAlign.Top},
                left:{anchor:"__container__",align: HorizontalAlign.Start},
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

              TextInput({ placeholder: "请输入手机号", text: this.phoneinputText, controller: this.controller })
                .inputFilter('[0-9]', (error) => {
                  promptAction.showToast({ message: "不是数字类型" })
                })
                .tabIndex(1)
                .padding({ left: 5 })
                .maxLength(11)
                .type(InputType.PhoneNumber)
                .fontSize(25)
                .backgroundColor(Color.White)
                .onChange((value) => {
                  this.phoneinputText = value;
                  this.user.userName = this.phoneinputText;
                  if ((this.user.userName.length == 11 && this.user.passWord.length >= 6) ||
                    (this.phoneInputState === Visibility.Visible && this.user.userName.length == 11)) {
                    this.buttonColor = 0x0066FF
                    this.loginButtonState = true
                  } else {
                    this.buttonColor = 0xF1F2F3
                    this.loginButtonState = false
                  }
                })
                .onFocus(() => {
                  this.PH1size = this.smallPHFont
                })
                .onBlur(() => {
                  this.PH1size = this.defaultPHFont
                })
                .placeholderFont({ size: this.PH1size })
                .enterKeyType(EnterKeyType.Next)
                .height("100%")
                .width(200)
                .alignRules({
                  top:{anchor:"__container__",align: VerticalAlign.Top},
                  left:{anchor:"phoneZone",align: HorizontalAlign.End },
                })
              Row(){
                Button(){Text("❌️")}
                .onClick(() => {
                  this.user.userName = '';
                  this.phoneinputText = '';
                })
                .backgroundColor(Color.White)
                .fontColor(Color.Black)
                .height("68%")
                .width("68%")
              }
              .justifyContent(FlexAlign.End)
              .width("15%")
              .height("100%")
              .alignRules({
                right:{anchor:"__container__",align: HorizontalAlign.End},
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
          RelativeContainer(){
            TextInput({ placeholder: "请输入密码",text:this.pinputText })
              .constraintSize({ minHeight: 50 })
              .tabIndex(1)
              .fontSize(18)
              .onChange((value: string) => {
                this.pinputText = value;
                this.user.passWord = this.pinputText;
                if (this.user.userName.length == 11 && this.user.passWord.length >= 6) {
                  this.buttonColor = 0x0066FF
                  this.loginButtonState = true
                } else {
                  this.buttonColor = 0xF1F2F3
                  this.loginButtonState = false
                }
              })
              .onFocus(() => {
                this.PH2size = this.smallPHFont
              })
              .onBlur(() => {
                this.PH2size = this.defaultPHFont
              })
              .enterKeyType(EnterKeyType.Done)
              .placeholderFont({ size: this.PH2size })
              .backgroundColor(Color.White)
              .type(InputType.NEW_PASSWORD)
              .padding({ left: 5 })
            Row(){
              Button(){
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
            .offset({
              x:-30
            })
            .width("15%")
            .height("100%")
            .alignRules({
              top:{anchor:"__container__",align: VerticalAlign.Top},
              right:{anchor:"__container__",align: HorizontalAlign.End},
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
          .onClick(() => {
            if (!this.user.isPrivacy) {

            }
            if (this.user.isPrivacy && this.loginButtonState) {
              console.debug(`${JSON.stringify(this.user)}`)
            }
          })
          .stateEffect(this.loginButtonState)
          .backgroundColor(this.buttonColor)
      }
      .height("100%")
      .layoutWeight(1)
      .visibility(this.passwdInputState)

      Row() {
        Button("获取短信验证码")
          .width("80%")
          .onClick(() => {
            if (this.user.isPrivacy && this.loginButtonState) {
              //console.debug(`${JSON.stringify(this.user)}`)
            }
          })
          .stateEffect(this.loginButtonState)
          .backgroundColor(this.buttonColor)
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

      Row() {
        Blank()
      }
      .height("100%")
      .layoutWeight(5)
    }
    .height('100%')
    .width('100%')
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
