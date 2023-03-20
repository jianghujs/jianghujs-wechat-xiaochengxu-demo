/**
 * 配置文件
 */
module.exports = {
  // appId: 'admin',
  // jianghuAxiosDomain: 'https://cn.openjianghu.org',
  appId: 'jianghujs-3table-crud',
  jianghuAxiosDomain: 'http://127.0.0.1:7002',
  
  api_url: "/api/food.",//接口路径（注意后面一点）
  version: "1.3.0",//版本号
  
  //下列参数发布H5版本必须配置参数
  domain: "https://demo.hemaphp.com", // api域名
  h5_url: "/h5/food/",//H5发布路径（存在服务器位置）与manifest.json中web配置一致
  applet_id: "10001", //初始默认小程序管理端编号（H5必填）
};