import {departments} from './departments'
import {Gender} from './Gender'

export class User {
  Phone = ""
  passWord = ""
  gender = Gender.Male
  department = departments[0]
  isPrivacy = false
  isAdv = false
  currentphoneZoneIndex = 0
}