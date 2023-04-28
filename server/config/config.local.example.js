'use strict';

const path = require('path');

module.exports = appInfo => {

  return {
    wechat: {
      devMode: true,
      // 微信配置（公众号、小程序、开放平台）
      apiConfig: {
        appId: 'appId',
        appScrect: 'appScrect',
        // token: 'token',
        // encryptMessage: true,
        // encodingAesKey: 'encodingAesKey'
      },
      // 企业微信配置（应用、小程序、第三方）
      qyApiConfig: {
        //     appId: 'appId',
        //     appScrect: 'appScrect',
        //     token: 'token',
        //     encryptMessage: true,
        //     encodingAesKey: 'encodingAesKey',
        //     corpId: '企业ID/服务商的企业ID'
      },
      // 微信支付配置
      wxPayApiConfig: {
        //     apiKey: 'apiKey',
        //     apiKey3: 'apiKey3',
        //     domain: 'domain',
        //     appId: '应用ID',
        //     mchId: '商户号',
        //     certP12Path: 'cert.p12',
        //     keyPath: 'key.pem',
        //     certPath: 'cert.pem',
        //     providerAppId: '服务商appId',
        //     provideMchId: '服务商商户号'
      },
    },

    static: {
      maxAge: 0,
      buffer: false,
      preload: false,
      maxFiles: 0,
    },
    logger: {
      outputJSON: true,
      consoleLevel: 'DEBUG',
      level: 'DEBUG',
      dir: path.join(appInfo.baseDir, 'logs'),
      contextFormatter(meta) {
        return `[${meta.date}] [${meta.level}] [${meta.ctx.method} ${meta.ctx.url}] ${meta.message}`;
      }
    },
    knex: {
      client: {
        dialect: 'mysql',
        connection: {
          host: '127.0.0.1',
          port: 3306,
          user: 'root',
          password: '123456',
          database: 'jianghujs_wechat_xiaochengxu_demo_server'
        },
        pool: { min: 0, max: 10 },
        acquireConnectionTimeout: 30000
      },
      app: true
    }
  };

};
