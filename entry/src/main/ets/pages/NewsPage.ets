import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'
import ALApiResponse from '../models/ALApiResponse'
import News from '../models/News'
import axios, { AxiosResponse } from '@ohos/axios'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct NewsPage {
  @State newsList: News[] = []

  readonly  PAGE_CAPACITY =10
  isLoading = false

  aboutToAppear(): void {
    this.requestNews()
  }

  build() {
    List() {
      Repeat<News>(this.newsList)
        .each((obj: RepeatItem<News>) => {
          ListItem() {
            Row() {
              Image(obj.item.imgsrc)
                .margin({ top: 20, bottom: 20 })
                .width(70)
                .height(70)
              Text(obj.item.title)
                .layoutWeight(1)
                .fontSize(16)
                .margin({ left: 8 })
            }
            .padding({left:8, right:8})
          }
          .onClick(() => {
            router.pushUrl({url: "pages/WebPage", params: {
              url: obj.item.m_url
            }})
          })
        })
        .key((item: News) => item.docid)
    }
    .onScrollIndex((start: number, end: number, center: number) => {
      console.log(`start ${start}, end ${end}, center ${center}, total ${this.newsList.length}`)

      if (end >= this.newsList.length - 1){
        this.requestNews()
      }
    })
    .height('100%')
    .width('100%')
  }

  private requestNews(){
    if(this.isLoading) {
      return
    }
    const pageNum = this.newsList.length / this.PAGE_CAPACITY + 1
    console.info("pageNum: " + pageNum)

    const url = `https://v2.alapi.cn/api/new/toutiao?token=SwKlqEWLJG4aHYDc&page=${pageNum}`
    const promise: Promise<AxiosResponse<ALApiResponse>> =  axios.get<ALApiResponse,AxiosResponse<ALApiResponse>>(url)
    this.isLoading = true
      promise.then((response: AxiosResponse<ALApiResponse>) => {
        console.info("response data: " + JSON.stringify(response))
        if (response.status === axios.HttpStatusCode.Ok){
          const newNewsList = response.data.data as News[]
          this.newsList = this.newsList.concat(newNewsList)
        }
        this.isLoading = false
      }).catch((error: BusinessError) => {
        console.info("error: " + JSON.stringify(error))
      })
    }
}