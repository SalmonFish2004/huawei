@Entry
@Component
struct Index {
  build() {
    Row() {

      RelativeContainer() {
        Row().width(100).height(100)
          .backgroundColor('#ff3339ff')
          .alignRules({
            top: {anchor: "__container__", align: VerticalAlign.Top},
            left: {anchor: "__container__", align: HorizontalAlign.Start}
          })
          .id("row1")

        Row().width(100)
          .backgroundColor('#ff298e1e')
          .alignRules({
            top: {anchor: "__container__", align: VerticalAlign.Top},
            right: {anchor: "__container__", align: HorizontalAlign.End},
            bottom: {anchor: "row1", align: VerticalAlign.Center},
          })
          .id("row2")

        Row().height(100)
          .backgroundColor('#ffff6a33')
          .alignRules({
            top: {anchor: "row1", align: VerticalAlign.Bottom},
            left: {anchor: "row1", align: HorizontalAlign.Start},
            right: {anchor: "row2", align: HorizontalAlign.Start}
          })
          .id("row3")

        Row()
          .backgroundColor('#ffff33fd')
          .alignRules({
            top: {anchor: "row3", align: VerticalAlign.Bottom},
            left: {anchor: "row1", align: HorizontalAlign.Center},
            right: {anchor: "row2", align: HorizontalAlign.End},
            bottom: {anchor: "__container__", align: VerticalAlign.Bottom}
          })
          .id("row4")

      }
      .width(300).height(300)
      .margin({left: 50})
      .border({width:2, color: "#6699FF"})
    }
    .height('100%')
  }
}