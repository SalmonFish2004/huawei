@Entry
@Component
struct Index {
  @State message: string = 'Hello 222';

  build() {
    Column(){
      Image($r("app.media"))
        .height(200)

    }
    .height('100%')
    .width('100%')
    Text(this.message)
  }
}