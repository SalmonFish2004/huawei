// import { http } from '@kit.NetworkKit'
// import { JSON } from '@kit.ArkTS'
// import json from '@ohos.util.json'
//
// @Entry
// @Component
// struct Page {
//   aboutToAppear(): void {
//     const httpRequest = http.createHttp()
//     httpRequest.on("headerReceive",(header)=>{
//       console.info("header:"+ JSON.stringify(header))
//     })
//     const url = ""
//     const promise = httpRequest.request(url)
//     promise.then((data)=>{
//       console.info("response data:"+ JSON.stringify(data))
//       if(data.responseCode == http.ResponseCode.OK){
//         const result = data.result
//         const data_ = JSON.parse(result as string) as Record<string, Object>
//         console.info("新闻标题0:"+ data_[0].title as string)
//       }
//     }).catch((error:BusinessError)=>{
//         console.info("error:"+JSON.stringify(error))
//     })
//   }
//
//   build() {
//     RelativeContainer() {
//       Text(this.message)
//         .id('PageHelloWorld')
//         .fontSize(50)
//         .fontWeight(FontWeight.Bold)
//         .alignRules({
//           center: { anchor: '__container__', align: VerticalAlign.Center },
//           middle: { anchor: '__container__', align: HorizontalAlign.Center }
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
// }