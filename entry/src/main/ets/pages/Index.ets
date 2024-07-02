@Entry
@Component
struct Index {
  @State message: string = 'Hello 222';

  build() {
    Text(this.message)
  }
}