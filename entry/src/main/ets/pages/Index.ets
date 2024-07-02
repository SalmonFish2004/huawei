@Entry
@Component
struct Index {
  @State message: string = 'Hello 222';

  build() {
    Column(){
      Image($r("app.media"))
        .width("100%")
        .height(150)
        //.backgroundColor(Color.Green)
        .objectFit(ImageFit.Fill)
    }
    .height('100%')
    .width('100%')
    Text(this.message)
  }
}