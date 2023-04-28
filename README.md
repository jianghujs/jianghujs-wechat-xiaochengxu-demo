# jianghujs-wechat-xiaochengxu-demo

## 配置&启动

1. 申请小程序测试号（https://mp.weixin.qq.com/wxamp/sandbox?doc=1），拿到AppId和AppSecret
2. server
    1. `npm install`
    2. 复制 `config.local.example.js` 为 `config.local.js`
    3. 并且修改数据库配置为自己的数据库, 例如：
        
        ```jsx
        // config/config.local.js
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: '123456',
        ```
        
    4. 修改微信公众号和企业微信相关配置,前面申请到的小程序appId和appSecret填到wechat.apiConfig下，例如:   
    5. 启动 `npm run dev`
3. 使用HBuilderX启动小程序
	1. 下载安装HBuilderX（https://www.dcloud.io/hbuilderx.html）
	2. 下载微信开发工具（https://developers.weixin.qq.com/miniprogram/dev/devtools/stable.html）
	3. 使用HBuilderX打开uniapp目录，点击菜单的“运行-运行到小程序模拟器-微信小程序”
