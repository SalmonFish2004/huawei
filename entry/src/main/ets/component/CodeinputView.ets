
@Component
export default struct CodeInputView {
  @State viewSize: number = 4
  inputResultCallback?: (value:string) => void
  @Link codeResult: string
  @State showCaret: boolean = false
  private inputKey = "code_input"
  @State codeKids:Array<string> = []
  readonly blank = "   "

  aboutToAppear() {
      this.codeKids = new Array<string>(this.viewSize).fill(this.blank);
  }

  needHighLight(item: string, index: number) {
    if(item!==this.blank){
      return Color.Black
    }
    else{
      if(index===0){
        return Color.Black
      }else{
        if(item===this.blank && this.codeKids[index-1]!==this.blank){
          return Color.Black
        }else
          return Color.Gray
      }
    }
  }

  build() {
    Stack() {
      TextInput()
        .maxLength(this.viewSize)
        .fontSize(25)
        .borderRadius(15)
        .type(InputType.Number)
        .key(this.inputKey)
        .onChange((value) => {
          let a = value.split('')
          this.codeKids.forEach((value:string, index:number) => {
            this.codeKids[index] = a[index] || this.blank
          })
          if (a.length >= this.viewSize) {
            this.inputResultCallback?.(value)
          }
        })
        .copyOption(CopyOptions.None)
        .caretColor(this.showCaret ? Color.Black : Color.Transparent)
        .fontColor(Color.Transparent)
        .backgroundColor(Color.White)
          //TODO 系统问题，如果背景色是透明的也没用，非透明可以
          // .stateStyles({ pressed: {.backgroundColor(“跟背景一样的颜色（纯透明会黑色闪一下）”)}})
        .height("100%")
        .width("100%")

      if (this.codeKids != null) {
        Row() {
          ForEach(this.codeKids, (item: string, index: number) => {
            Column() {
                Text(item)
                  .height("90%")
                  .width("100%")
                  .fontSize(25)
                  .textAlign(TextAlign.Center)
                  .align(Alignment.Bottom)
                  .focusable(false)
                  .defaultFocus(false)
                  .focusOnTouch(false)
                  .padding({bottom:15})
                Row() {
                }.width("60%").height(1).backgroundColor(this.needHighLight(item, index))
            }
            .height("100%")
            .width("100%")
            .layoutWeight(1)
          }, (item: string) => item)
        }
        .onClick(() => {
          focusControl.requestFocus(this.inputKey)
        })
        .height("100%")
        .width("100%")
      }
    }
    .height(80)
  }
}