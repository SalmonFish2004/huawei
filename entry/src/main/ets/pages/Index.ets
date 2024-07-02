@Entry
@Component
struct Index {
  @State message: string = 'Hello';

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
      .margin({ top: 100 })

      Image($r("app.media.BG"))
        .width("100%")
        .height(150)//.backgroundColor(Color.Green)
        .objectFit(ImageFit.Cover)

      Row() {
        Text("用户名")
          .fontSize(20)
        TextInput({ placeholder: "请输入用户名" })
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
          .width(200)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 30, left: 20, right: 20, })
      .padding({ left: 40, right: 40 })
    }
    .height('100%')
    .width('100%')
  }
}