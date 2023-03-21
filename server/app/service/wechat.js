'use strict';

// ========================================常用 require start===========================================
const Service = require('egg').Service;
const validateUtil = require('@jianghujs/jianghu/app/common/validateUtil');
const idGenerateUtil = require('@jianghujs/jianghu/app/common/idGenerateUtil');
const geoip = require('geoip-lite');
// ========================================常用 require end=============================================

const { ApiConfigKit, MiniProgramApi } = require('tnwx')

const actionDataScheme = Object.freeze({
  login: {
    type: 'object',
    additionalProperties: true,
    properties: {
      code: { type: 'string' },
      deviceId: { type: 'string' },
      deviceType: { type: 'string' },
      userAgent: { type: 'string' },
    },
  }
});

class WechatService extends Service {

  // 登录
  async login() {
    const app = this.app;
    const { jianghuKnex } = app;
    const { appId, wechat } = app.config;
    const { actionData } = this.ctx.request.body.appData;
    validateUtil.validate(actionDataScheme.login, actionData);

    const { code, deviceId, deviceType, userAgent } = actionData

    // 微信登录
    const sessionResult = await MiniProgramApi.code2Session(ApiConfigKit.getAppId, ApiConfigKit.getApiConfig.getAppScrect, code)
    const { openid, session_key: sessionKey } = sessionResult;

    const userExistCountResult = await jianghuKnex('_user', this.ctx).where({ openid }).count('*', { as: 'count' });
    const userExistCount = userExistCountResult[0].count;
    if (userExistCount == 0) {
      await jianghuKnex('_user', this.ctx)
        .jhInsert({
          userId: 'wx_' + idGenerateUtil.uuid(36),
          openid,
          sessionKey,
          username: 'wx_' + idGenerateUtil.uuid(36),
          avatar: '',
          userType: 'wxxcx_user'
        });
    } else {
      await jianghuKnex('_user', this.ctx)
        .where({ openid })
        .jhUpdate({
          sessionKey,
        });
    }
    let user = await jianghuKnex('_view01_user', this.ctx)
      .where({ openid })
      .first();

    const { userId } = user
    const authToken = await this.generateAuthToken(userId, deviceId, deviceType, userAgent)
    return { authToken, deviceId, userId };
  }

  async generateAuthToken(userId, deviceId, deviceType, userAgent) {
    const app = this.app;
    const { jianghuKnex } = app;

    const authToken = idGenerateUtil.uuid(36);
    // 存session 的目的是为了
    //   1. 系统可以根据这个判断是否是自己生成的token
    //   2. 有时候系统升级需要 用户重新登陆/重新登陆，这时候可以通过清理旧session达到目的
    const userSession = await jianghuKnex('_user_session')
      .where({ userId, deviceId })
      .first();

    const userIp = this.ctx.header['x-real-ip'] || this.ctx.request.ip || '';
    const geo = geoip.lookup(userIp);
    let userIpRegion = '';
    if (geo) {
      userIpRegion = `${geo.country}|${geo.region}|${geo.timezone}|${geo.city}|${geo.ll}|${geo.range}`;
    }

    if (userSession && userSession.id) {
      await jianghuKnex('_user_session', this.ctx)
        .where({ id: userSession.id })
        .jhUpdate({ authToken, deviceType, userAgent, userIp, userIpRegion });
    } else {
      await jianghuKnex('_user_session', this.ctx).jhInsert({
        userId,
        deviceId,
        userAgent,
        userIp,
        userIpRegion,
        deviceType,
        authToken
      });
    }

    return authToken;
  }

  // 更新微信用户名
}

module.exports = WechatService;
