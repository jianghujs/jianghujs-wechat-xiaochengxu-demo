'use strict';
const { ApiConfig, ApiConfigKit } = require('tnwx')

class AppBootHook {
  constructor(app) {
    this.app = app;
  }

  /**
   * 参考：https://github.com/Javen205/TNWX/blob/master/sample/egg/app.ts
   * 或：https://github.com/undsky/egg-wechat/blob/master/app.js
   */
  async didReady() {

    let config = this.app.config

    let apiConfig = new ApiConfig(config.wechat.apiConfig.appId, config.wechat.apiConfig.appScrect)
    ApiConfigKit.putApiConfig(apiConfig)
    if (config.wechat.devMode) {
      ApiConfigKit.devMode = true
    }
  }

}

module.exports = AppBootHook;

