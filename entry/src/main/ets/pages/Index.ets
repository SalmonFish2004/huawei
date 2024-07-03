@Entry
@Component
struct Index {
  @State message: string = 'Hello';
  @State currentDepartmentIndex: number = 0
  departments = [
    "请选择院系",
    "信息技术学院",
    "外国语学院",
    "珠宝学院",
    "机电学院"
  ]

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
      .margin({ top: 50 ,bottom:20})

      Image($r("app.media.BG"))
        .width("100%")
        .height(150)//.backgroundColor(Color.Green)
        .objectFit(ImageFit.Cover)

      Row() {
        Text("用户名")
          .fontSize(20)
        TextInput({ placeholder: "请输入用户名" })
          .borderRadius(8)
          .width(200)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 30, left: 20, right: 20, })
      .padding({ left: 40, right: 40 })

      Row() {
        Text("密码")
          .fontSize(20)
        TextInput({ placeholder: "请输入密码" })
          .borderRadius(8)
          .type(InputType.NEW_PASSWORD)
          .width(200)
      }
      .width("100%")
//<<<<<<< Updated upstream
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 30, left: 20, right: 20, })
      .padding({ left: 40, right: 40 })
//=======
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
        Text(`${this.departments[this.currentDepartmentIndex]}`)
          .fontSize(18)
        Text("🔽")
          .fontSize(20)
      }
      .bindMenu(this.menuBuilder)
      .width("50%")
      .borderRadius(8)
      .height(40)
      .margin({ top: 30 })
      .padding({ left: 12, right: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(0xF1F2F3)

      Blank()
      Button("注册")
        .width("80%")

      Row() {
        Checkbox()
          .shape(CheckBoxShape.ROUNDED_SQUARE)
        Text("我接受隐私条款与用户协议")
      }
      .margin(50)

//>>>>>>> Stashed changes
    }

    .height('100%')
    .width('100%')
  }

  @
  Builder
  menuBuilder() {
    List() {
      ForEach(this.departments, (item: string, index: number) => {
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
    .height(this.departments.length * 32 - 2)
  }
}