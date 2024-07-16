import { User } from './User';

export default class UserPhoneNumData {
  user = new User()
  constructor(id: number,phone:string) {
    this.user.currentphoneZoneIndex = id;
    this.user.Phone = phone;
  }
}